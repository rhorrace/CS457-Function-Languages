> {-# LANGUAGE BlockArguments #-}

Robert Horrace
CS457
Project

> module Hand where
> import Types
> import Data.List
> import Data.Ord
> import Data.Function

> getRankHand     :: [Card] -> (Rank, [Card])
> getRankHand hnd = case isFlush hnd of
>                     Nothing   -> case isStraight hnd of
>                                    Nothing     -> getCards hnd
>                                    Just strght -> (Straight, strght)
>                     Just flsh -> case isStraight flsh of
>                                    Nothing     -> (Flush, take 5 flsh)
>                                    Just strght -> if isRoyal strght then (RoyalFlush, strght)
>                                                   else                   (StraightFlush, strght)
>                 where isRoyal    :: [Card] -> Bool
>                       isRoyal cs | length ryl == 5 = True
>                                  | otherwise       = False
>                                  where rf  = [VA,VK,VQ,VJ,V10]
>                                        ryl = filter (flip elem rf . value) cs

> isFlush    :: [Card] -> Maybe [Card]
> isFlush cs | length flsh >= 5 = Just flsh
>            | otherwise        = Nothing
>            where groupSuit :: [Card] -> [[Card]]
>                  groupSuit = groupBy ((==) `on` suit)
>                  sortSuit  :: [Card] -> [Card]
>                  sortSuit  = sortBy (comparing suit <> flip compare)
>                  flsh      = head $ sortLength $ groupSuit $ sortSuit cs

> isStraight    :: [Card] -> Maybe [Card]
> isStraight cs | length strght >= 5 = Just (lastNCards 5 strght)
>               | otherwise          = lowStraight cs'
>               where groupSucc      :: [Card] -> [[Card]]
>                     groupSucc      = foldr f []
>                                    where f x []         = [[x]]
>                                          f x cs@(c:cs') | succ (value x) == value (head c) = (x:c):cs'
>                                                         | otherwise = [x]:cs
>                     cs'            = nubBy ((==) `on` value) cs
>                     strght         = head $ sortLength $ groupSucc $ sort cs'
>                     lastNCards     :: Int -> [Card] -> [Card]
>                     lastNCards n   = foldl' (const . tail) <*> drop n
>                     lowStraight    :: [Card] -> Maybe [Card]
>                     lowStraight cs | length strght == 5 = Just strght
>                                    | otherwise          = Nothing
>                                    where low    = [VA, V2, V3, V4, V5]
>                                          strght = filter (flip elem low . value) cs

> getCards    :: [Card] -> (Rank, [Card])
> getCards cs = (r, cs')
>             where gcs = sortLength $ groupBy ((==) `on` value) $ sort cs
>                   cs' = take 5 $ concat gcs
>                   r   = case map length gcs of
>                           (4:_)   -> FourOfKind
>                           (3:3:_) -> FullHouse
>                           (3:2:_) -> FullHouse
>                           (3:_)   -> ThreeOfKind
>                           (2:2:_) -> TwoPair
>                           (2:_)   -> OnePair
>                           _       -> HighCard

> sortLength :: Ord a => [[a]] -> [[a]]
> sortLength = sortBy (flip (comparing length) <> flip compare)
