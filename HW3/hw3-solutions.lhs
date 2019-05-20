----------------------------------------------------------------------
CS457/557 Functional Languages, Winter 2019                 Homework 3

Robert Horrace
CS 457

Homework 3 Solutions
------------

> data Bit = O | I
>   deriving Show




> type BinNum = [Bit]




> eq :: BinNum -> BinNum -> Bool
> eq (O:xs) (O:ys) = eq xs ys
> eq (I:xs) (I:ys) = eq xs ys
> eq []     ys     = isZero ys
> eq xs     []     = isZero xs
> eq xs     ys     = False



> isZero :: BinNum -> Bool
> isZero  = all isO
>  where isO O = True
>        isO I = False

------------
a)

eq [O] [I]
eq [I] [I]
eq [O] [O]
isZero [I]
isZero [O]
isZero [O,O,O,O,I]
isZero [O,O,O,O,O]
------------
b)

> toBinNum   :: Integer -> BinNum


> toBinNum n | n==0   = []
>            | even n = O : toBinNum halfOfN
>            | odd n  = I : toBinNum halfOfN
>              where halfOfN = n `div` 2

toBinNum 0
[O]
toBinNum 2
[O,I]
toBinNum 4
[O,O,I]
toBinNum 6
[O,I,I]
toBinNum 8
[O,O,O,I]
toBinNum 1
[I]
toBinNum 3
[I,I]
toBinNum 5
[I,O,I]
toBinNum 7
[I,I,I]

> enum = zip [0..]

> fromBinNum      :: BinNum -> Integer
> fromBinNum []   = 0
> fromBinNum ds   | is0 (last ds) = fromBinNum (init ds)
>                 | otherwise = 2^(length ds - 1) + fromBinNum (init ds)
>   where is0 O = True
>         is0 I = False

fromBinNum [O]
0
fromBinNum [I]
1
fromBinNum [O,I]
2
fromBinNum [I,I]
3
fromBinNum [O,O,I]
4
fromBinNum [I,O,I]
5
fromBinNum [I,I,I]
7
fromBinNum [O,O,O,I]
8

-------------
c)


> inc        :: BinNum -> BinNum
> inc []     = [I]
> inc (O:ds) = I : ds
> inc (I:ds) = O : inc ds

inc [O]
[I]
inc [I]
[O,I]
inc [O,I]
[I,I]
inc [I,I]
[O,O,I]
--------------
d)

> add :: BinNum -> BinNum -> BinNum
> add []     ds     = ds
> add ds     []     = ds
> add (O:ds) (e:es) = e : add ds es
> add (I:ds) (O:es) = I : add ds es
> add (I:ds) (I:es) = O : add (add [I] ds) (es)

add [I,O,I] [I,O,I]
[O,I,I,I]
add [I,I,I] [I,O,I]
[O,O,I,I]
add [I,O,I] [I,I,I]
[O,O,I,I]
add [I,I,I] [I,I,I]
[O,I,I,I,I]
--------------
e)

> multBit          :: Bit -> BinNum -> BinNum
> multBit _ []     = []
> multBit O (d:ds) = O : multBit O ds 
> multBit I (d:ds) | is0 d     = O : multBit I ds
>                  | otherwise = I : multBit I ds
>   where is0 O = True
>         is0 I = False

> mult           :: BinNum -> BinNum -> BinNum
> mult [] []     = [O]
> mult [] ds     = take (length ds) (cycle [O])
> mult ds []     = take (length ds) (cycle [O])
> mult (d:ds) es = add (xs) (O : (mult ds es))
>   where xs = multBit d es

Law:
mult x y = toBinNum (fromBinNum x * fromBinNum y)

mult [] []
[O]
mult [] [I,I,I]
[O,O,O]
mult [] [I,I,I]
[O,O,O]
mult [I,I,I] [I,O,I]
[I,I,O,O,O,I]
mult [I,O,I] [I,I,I]
[I,I,O,O,O,I]
mult [I,I,I] [I,I,I]
[I,O,O,O,I,I]
