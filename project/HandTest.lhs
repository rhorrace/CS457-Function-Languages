> {-# LANGUAGE BlockArguments #-}

> module HandTest where
> import Hand
> import Types

> main :: IO ()
> main = do putStrLn "Testing High Card"
>           let (rank,_) = getRankHand [(Card VA H),(Card V4 H),(Card V6 C),(Card V8 C),(Card V9 D),(Card V10 D),(Card VJ D)]
>           putStrLn (show (rank == HighCard))
>           putStrLn "Testing One Pair"
>           let (rank,_) = getRankHand [(Card VA H),(Card VA D),(Card V6 C),(Card V8 C),(Card V9 D),(Card V10 D),(Card VJ D)]
>           putStrLn (show (rank == OnePair))
>           putStrLn "Testing Two Pair"
>           let (rank,_) = getRankHand [(Card VA H),(Card VA D),(Card V6 C),(Card V8 C),(Card V9 D),(Card V10 D),(Card V10 C)]
>           putStrLn (show (rank == TwoPair))
>           putStrLn "Testing Three of a Kind"
>           let (rank,_) = getRankHand [(Card VA H),(Card VA D),(Card VA C),(Card V8 C),(Card V9 D),(Card V10 D),(Card VJ D)]
>           putStrLn (show (rank == ThreeOfKind))
>           putStrLn "Testing Straight"
>           putStrLn "\tLow Straight"
>           let (rank,_) = getRankHand [(Card VA H),(Card V4 H),(Card V2 C),(Card V5 C),(Card V3 D),(Card V10 D),(Card VJ D)]
>           putStrLn ("\t" ++ (show (rank == Straight)))
>           putStrLn "\tNormal Straight"
>           let (rank,_) = getRankHand [(Card VA H),(Card V4 H),(Card V6 C),(Card V8 C),(Card V9 D),(Card V7 D),(Card V5 D)]
>           putStrLn ("\t" ++ (show (rank == Straight)))
>           putStrLn "Testing Flush"
>           let (rank,_) = getRankHand [(Card VA H),(Card V4 H),(Card V6 H),(Card V8 H),(Card V9 D),(Card V10 H),(Card VJ D)]
>           putStrLn (show (rank == Flush))
>           putStrLn "Testing Full House"
>           putStrLn "\tTesting Three of a kind and pair"
>           let (rank,_) = getRankHand [(Card VA H),(Card V4 H),(Card VA C),(Card V8 C),(Card VA D),(Card V4 D),(Card VJ D)]
>           putStrLn ("\t" ++ (show (rank == FullHouse)))
>           putStrLn "\tTesting two Three of a kinds"
>           let (rank,_) = getRankHand [(Card VA H),(Card V4 H),(Card VA C),(Card V4 C),(Card VA D),(Card V4 D),(Card VJ D)]
>           putStrLn ("\t" ++ (show (rank == FullHouse)))
>           putStrLn "Testing Four of a Kind"
>           let (rank,_) = getRankHand [(Card VA H),(Card V4 H),(Card VA C),(Card V8 C),(Card VA D),(Card V10 D),(Card VA S)]
>           putStrLn (show (rank == FourOfKind))
>           putStrLn "Testing Straight Flush"
>           let (rank,_) = getRankHand [(Card VA H),(Card V7 C),(Card V6 C),(Card V8 C),(Card V9 C),(Card V10 C),(Card VJ D)]
>           putStrLn (show (rank == StraightFlush))
>           putStrLn "Testing Royal Flush"
>           let (rank,_) = getRankHand [(Card VA H),(Card V7 C),(Card V10 H),(Card VK H),(Card V9 C),(Card VQ H),(Card VJ H)]
>           putStrLn (show (rank == RoyalFlush))
