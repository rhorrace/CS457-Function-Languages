Robert Horrace
CS 457
Homework 4 Solutions

> import Countdown
> import Data.List

Part 1:

Exercise 1

> choices' :: [a] -> [[a]]
> choices' xs = [ps | s  <- (subs xs),
>                     ps <- perms s]

Tests:
choices [1,2] 
[[],[2],[1],[1,2],[2,1]]
choices' [1,2]
[[],[2],[1],[1,2],[2,1]]

Exercise 2

> remfst          :: Eq a => a -> [a] -> [a]
> remfst _ []     = []
> remfst x (y:ys) | x == y    = ys
>                 | otherwise = y : remfst x ys

Tests:
remfst 1 [3,4,5,6,1,1]
[3,4,5,6,1]
remfst 3 [3,4,5,6,1,1,2,3]
[4,5,6,1,1,2,3]

> isChoice          :: Eq a => [a] -> [a] -> Bool
> isChoice [] _      = True
> isChoice _ []      = False
> isChoice (x:xs) ys | not (elem x ys) = False
>                    | otherwise       = isChoice xs (remfst x ys)

Tests:
isChoice [] [1]
True
isChoice [1] []
False
isChoice [1,2] [1]
False
isChoice [1] [1,2]
True
isChoice [1,2] [1,2,3]
True

Exercise 3

Termination would be impossible

Exercise 4

> possExprs :: [Int] -> [Expr]
> possExprs = concat . map exprs . choices

Tests:
possExprs [1]
[1]
possExprs [1,2]
[2,1,1+2,1-2,1*2,1/2,2+1,2-1,2*1,2/1]

> succExprs :: [Int] -> [[Int]]
> succExprs = filter (not . null) . map eval . possExprs

Tests:
succExprs [1]
[[1]]
succExprs [1,2]
[[2],[1]],[3],[2],[3],[1],[2],[2]]

> totPos :: [Int] -> Int
> totPos = length . possExprs

Tests:
totPos [1]
1
totPos [1,2]
10


> totSucc :: [Int] -> Int
> totSucc = length . succExprs

Tests:
totsucc [1]
1
totsucc [1,2]
8

Requirement Test:
totPos [1,3,7,10,25,50]
33665406
totSucc [1,3,7,10,25,50]
4672540

Exercise 6b:

> closest      :: Int -> [Int] -> Int
> closest _ [] = 0
> closest n ns = if elem (n - x) ns then n - x else n + x
>                where x = minimum (map (abs) (map (n-) ns))

Tests:
closest 100 []
0
closest 1 [1,2,3]
1
closest 2 [1,2,3]
2
closest 3 [1,2,3]
3
closest 4 [1,2,3]
3
closest 5 [1,2,3]
3
closest 3 [1,4]
4


Part 2:

a)

> cat       :: Int -> Integer
> cat 0     = 1 
> cat 1     = 1
> cat n     = sum (zipWith (*) ns nis)
>           where ns = map cat [0..n-1]
>                 nis = map cat (map (\i -> n - i - 1) [0..n-1]) 

Tests:
cat 1
1
cat 2
2
cat 3
5
cat 4
14
cat 5
42
cat 6
132
cat 7
429
cat 8
1430
cat 9
4862
cat 10
16796
starts slowing down with values 10+

b)

> catalans :: Int -> [Integer]
> catalans n = reverse (map cat [0..n])

Tests:
catalans 4
[14,5,2,1,1]
catalans 5
[42,14,5,2,1,1]

> nextcat :: [Integer] -> [Integer]
> nextcat ns = (cat (length ns)) : ns

Tests:
nextcat [14,5,2,1,1]
[42,14,5,2,1,1]
nextcat (catalans 4)
[42,14,5,2,1,1]


c)

choose function from rosettacode

> choose :: Integer -> Integer -> Integer
> choose n k = product [k+1..n] `div` product [1..n-k]

Tests:
choose 0 0
1
choose 0 1
1
choose 1 0
1
choose 1 1
1
choose 4 2
6
choose 2 4
1

> fastcat :: Int -> Integer
> fastcat n = (choose (2*n') (n')) `div` (n'+ 1)
>           where n' = fromIntegral n

Tests:
fastcat 0
1
fastcat 1
1
fastcat 2
2
fastcat 3
5
fastcat 4
14
fastcat 5
42

d)

Function defined to determine length of catalan number

> numDigits = length . show . fastcat

Lowest 300 digit catalan: (fastcat 504)

Part 3:

> split'        :: [a] -> [([a],[a])]
> split' []     = []
> split' [n]    = []
> split' (n:ns) = ([n],ns) : [ (n:ls, rs) | (ls, rs) <- split' ns]

a)

> layout :: [String] -> IO ()
> layout  = putStr
>         . unlines
>         . zipWith (\n l -> show n ++ ") " ++ l) [1..]

> appString    :: String -> String -> String
> appString l r = "(" ++ l ++ "++" ++ r ++ ")"

> allWays   :: String -> [String]
> allWays [] = []
> allWays xs = xs : [appString l r | (ls, rs) <- split' xs,
>                                     l       <- allWays ls,
>                                     r       <- allWays rs]

Tests:
layout (allWays "abc")
1) abc
2) (a++bc)
3) (a++(b++c))
4) (ab++c)
5) ((a++b)++c)

layout (allWays "abcd")
1) abcd
2) (a++bcd)
3) (a++(b++cd))
4) (a++(b++(c++d)))
5) (a++(bc++d))
6) (a++((b++c)++d))
7) (ab++cd)
8) (ab++(c++d))
9) ((a++b)++cd)
10) ((a++b)++(c++d))
11) (abc++d)
12) ((a++bc)++d)
13) ((a++(b++c))++d)
14) ((ab++c)++d)
15) (((a++b)++c)++d)


b)

> noParens   :: String -> [String]
> noParens xs = nub $ xs : [l ++ "++" ++ r | (ls, rs) <- split' xs,
>                                             l       <- noParens ls,
>                                             r       <- noParens rs]

Tests:
layout (noParens "abc")
1) abc
2) a++bc
3) a++b++c
4) ab++c

layout (noParens "abcd")
1) abcd
2) a++bcd
3) a++b++cd
4) a++b++c++d
5) a++bc++d
6) ab++cd
7) ab++c++d
8) abc++d

