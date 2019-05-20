> {-# LANGUAGE BlockArguments #-}

> module Game where
> import Hand
> import Types
> import Data.List
> import Data.Maybe
> import Control.Concurrent

> startDeck = [(Card v s) | v <- [minBound..maxBound], s <- [minBound..maxBound]]

> main = play startDeck 

> play :: [Card] -> IO()
> play dck = do 
>               -- Deal Phase
>               clear 0
>               let d1 = shuffle dck
>               let game = Table { flop = [], turn = [], river = [] }
>               let (p, c) = dealPlayers $ d1
>               let (h_r_p, h_p) = getRankHand p
>               let (h_r_c, h_c) = getRankHand c
>               let player = Player {deal = p, hand = h_p, hand_rank = h_r_p}
>               let computer = Player {deal = c, hand = h_c, hand_rank = h_r_c}
>               putStrLn ("Your Deal: " ++ (show $ deal player))
>               putStrLn (show $ hand_rank player)
>               threadDelay 1000000
>               -- Flop Phase
>               clear 0
>               let dealer = drop 4 $ d1
>               let (f, t, r) = dealTable dealer
>               let game = Table { flop = f, turn = [], river = [] }
>               let (h_r_p, h_p) = getRankHand (hand player ++ f)
>               let (h_r_c, h_c) = getRankHand (hand computer ++ f)
>               let player = Player { deal = p, hand = h_p, hand_rank = h_r_p }
>               let computer = Player { deal = c, hand = h_c, hand_rank = h_r_c }
>               putStrLn ("Your Deal: " ++ (show $ deal player))
>               displayTable game
>               putStrLn ("Your Hand: " ++ (show $ hand player))
>               putStrLn (show $ hand_rank player)
>               threadDelay 1000000
>               -- Turn Phase
>               clear 0
>               let game = Table { flop = f, turn = t, river = [] }
>               let (h_r_p, h_p) = getRankHand (hand player ++ t)
>               let (h_r_c, h_c) = getRankHand (hand computer ++ t)
>               let player = Player { deal = p, hand = h_p, hand_rank = h_r_p }
>               let computer = Player { deal = c, hand = h_c, hand_rank = h_r_c }
>               putStrLn ("Your Deal: " ++ (show $ deal player))
>               displayTable game
>               putStrLn ("Your Hand: " ++ (show $ hand player))
>               putStrLn (show $ hand_rank player)
>               threadDelay 1000000
>               -- River Phase
>               clear 0
>               let game = Table { flop = f, turn = t, river = r }
>               let (h_r_p, h_p) = getRankHand (deal player ++ f ++ t ++ r)
>               let (h_r_c, h_c) = getRankHand (deal computer ++ f ++ t ++ r)
>               let player = Player { deal = p, hand = h_p, hand_rank = h_r_p }
>               let computer = Player { deal = c, hand = h_c, hand_rank = h_r_c }
>               putStrLn ("Your Deal: " ++ (show $ deal player))
>               displayTable game
>               putStrLn ("Your Hand: " ++ (show $ hand player))
>               putStrLn (show $ hand_rank player)
>               threadDelay 1000000
>               -- Winner Phase
>               clear 0
>               putStrLn ("Your Deal: " ++ (show $ deal player))
>               putStrLn ("Comp Deal: " ++ (show $ deal computer))
>               displayTable game
>               putStrLn ("Your Hand: " ++ (show $ hand player))
>               putStrLn (show $ hand_rank player)
>               putStrLn ("Comp Hand: " ++ (show $ hand computer))
>               putStrLn (show $ hand_rank computer)
>               case winner player computer of
>                 Nothing    -> putStrLn "It's a Tie."
>                 Just True  -> putStrLn "Yay, you win!"
>                 Just False -> putStrLn "Sorry, you lose."
>               threadDelay 1000000
>               -- Play again?
>               putStr "Play again? (y/n): "
>               h <- getChar
>               if h == 'y'      then do putStr "\n\n"
>                                        play d1
>               else if h == 'n' then putStrLn "\nGoodbye"
>               else do putStr "\n\n"
>                       let d1 = drop 5 dealer
>                       if length d1 >= 9 then play d1
>                       else play startDeck

> shuffle :: [Card] -> [Card]
> shuffle = last . take 10 . iterate (riffle . reverse . riffle)
>         where riffle :: [Card] -> [Card]
>               riffle [] = []
>               riffle cs = merge ls (rs)
>                         where ls = take (length cs `div` 2) cs
>                               rs = drop (length cs `div` 2) cs
>                               merge :: [Card] -> [Card] -> [Card]
>                               merge []     []     = []
>                               merge xs     []     = xs
>                               merge []     ys     = ys
>                               merge (x:xs) (y:ys) = x:y:merge (ys) (xs)

> clear :: Int -> IO()
> clear n | n == 100 = putStr "\n"
>         | otherwise = do putStr "\n"
>                          clear (n+1)

> dealPlayers     :: [Card] -> ([Card],[Card])
> dealPlayers dck = (lp,rp)
>                 where (ls,rs) = splitAt 2 (take 4 dck)
>                       lp      = init ls ++ init rs
>                       rp      = tail ls ++ tail rs

> dealTable     :: [Card] -> ([Card], [Card], [Card])
> dealTable dck = (take 3 cs , init cs',  tail cs')
>               where cs  = take 5 dck
>                     cs' = drop 3 cs 

> displayTable :: Table -> IO()
> displayTable tbl = putStrLn ("Table:" ++ f ++ t ++ r)
>                  where f = if null $ flop tbl then "" 
>                            else ("\n\tflop:  " ++ (show $ flop tbl))
>                        t = if null $ turn tbl then "" 
>                            else ("\n\tturn:  " ++ (show $ turn tbl))
>                        r = if null $ river tbl then "" 
>                            else ("\n\triver: " ++ (show $ river tbl))

> winner :: Player -> Player -> Maybe Bool
> winner p c | hand_rank p > hand_rank c = Just True
>            | hand_rank p < hand_rank c = Just False
>            | otherwise                 = tieBreaker (hand p) (hand c)
>            where tieBreaker :: [Card] -> [Card] -> Maybe Bool
>                  tieBreaker []     []     = Nothing
>                  tieBreaker (l:ls) (r:rs) | value l > value r     = Just True
>                                           | value l < value r     = Just False
>                                           | otherwise             = tieBreaker ls rs
