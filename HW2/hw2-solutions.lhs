Robert Horrace
CS 457
Homework 2 solutions

> import Data.List

Chapter 5 Question 6

> factors :: Int -> [Int]
> factors n = [z | z <- [1..n], n `mod` z == 0]

> perfectnums :: Int -> [Int]
> perfectnums n = [x | x <- [1..n], sum (factors x) - x == x]

Chapter 6 Question 7

> merge :: Ord a => [a] -> [a] -> [a]
> merge xs [] = xs
> mergel [] ys = ys
> merge (x:xs) (y:ys) | x < y     = x : merge xs (y:ys)
>                     | otherwise = y : merge (x:xs) ys

Question 1

 
a) map even :: Integral a => [a] -> [bool]
 
b) takeWhile not :: [Bool] -> [Bool]
 
c) ([]++) :: [a] -> [a]
 
d) (:[]) :: a -> [a]
 
e) ([]:) :: [[a]] -> [[a]]
 
f) [ [], [[]], [[[]]], [[[[]]]], [[[[[    ]]]]] ]
    :: [[[[[[a]]]]]]

g) [ [], [[]], [[[]]], [[[[]]]], [[[[[True]]]]] ]
    :: [[[[[[Bool]]]]]]
 
h) [ [True], [[]], [[[]]], [[[[]]]], [[[[[]]]]] ]
 
Inconsistent use of lists lead to errors in ghci
theoretical: Bool a => [[a], [[a]], [[[a]]], [[[[a]]]], [[[[[a]]]]]]

i) map map :: [a -> b] -> [[a] -> [b]]
 
j) map (map even) :: integral a => [[a]] -> [[Bool]]
 
k) map . map :: (a -> b) -> [[a]] -> [[b]]
 
l) (map , map) 
   ::((a1 -> b1) -> [a1] -> [b1], (a2 -> b2) -> [a2] -> [b2])

 
m) [ map id, reverse, map not ] :: [[Bool] -> [Bool]]


Question 2

a) even . (1+) is a function that "adds one to a 
value (a whole number) and determines if that value 
(after 1 is added) is even." For example, if the 
function was given the value 2, the function 
determine if 1+2 is even, which i should not be, 
since 1+2 equals 3, and 3 is odd.

b) even . (2*) is a function that "doubles a value 
(a whole number) and determines if that value (after 
being doubled) is even." This function is a 
tautology, due to any double of a value is even.

c) ([1..]!!) is a function that "returns the value
of a specific index of an infinite list which starts
at 1."

d) (!!0) is a function that "returns the value of
the front (or head) of the list, similar to the 
head function."

e) reverse . reverse is a function that "reverses
a list of values and then reverses it again, giving
the list of values in its original order."

f) reverse . tail . reverse is a function that
"return a list of values, except for the last 
element, by reversing the list, then remove the 
first element of the reversed list, then reversing 
it again, giving a list which the last element of 
the original list was removed."

g) map reverse . reverse . map reverse is a function
that "reverse a list of list of values, meaning the
first list in the list of lists becomes the last list
in the list of lists, vice versa, and all lists in
the lists of lists are swapped with their respective
counterparts."

Question 3

a)

concat . concat :: Foldable t => t [[a]] -> [a]

concat . map concat :: Foldable t => [t [a]] -> [a]

b)

> xsss = [ [[1], [2, 3]], [[4]], [[5], [6]] ]

List representation spaced out for readability

          [1,2,3,4,5,6]
               ^
               |
concat    [ [1], [2, 3], [4], [5], [6] ]
               ^
               |
 . concat [ [ [1], [2, 3] ], [ [4] ], [ [5], [6] ] ]

[ [1], [2, 3] ]     [ [4] ]     [ [5], [6] ]
      |                |              |
      v                v              v
[ [1]  [2, 3]         [4]         [5]  [6] ]
      |                |              |
      v                v              v
[  1,   2, 3           4,          5,   6  ]

The function concatenates each xss in xsss to convert
xsss into an xss, which then concatenates each xs in
the xss to become x, which makses xss to an xs

            [1,2,3,4,5,6]
                 ^
                 |  
concat      [ [1,2,3], [4], [5,6] ]
                 ^
                 |
.map concat [ [ [1], [2, 3]], [ [4] ], [ [5], [6] ] ]

[ [1], [2, 3] ]     [ [4] ]     [ [5], [6] ]
      |                |              |
      v                v              v
[ [1,   2, 3]         [4]         [5,   6] ]
      |                |              |
      v                v              v
[  1,   2, 3           4,          5,   6  ]

The function concatenates the xs in each xss of xss,
which makes xsss become an xss. Then the function
concatenates the xs in the new xss, whihc makes xss in an xs.

c)

lhf = left hand function, rhf = right hanf function.

The lhf concatenates the lists in xsss the concatenates
that formed xss, making it into an xs. The rhf concatenates 
the lists inside the lists inside the list, making xsss into
an xss, then concatenates the lists inside xss, making xss
into an xs.

Question 4

a)

> integers :: [Integer]
> integers = 0 : [y | x <- [1..], y <- [x, -x]]

b)

> pairs :: [(Integer, Integer)]
> pairs = [(n,m) | n <- [0..], m <- [0..]]

This definition leads to an infinite list of pairs,
which can lead to one row being an infinite list
where n is 0, and m is anything or vice versa.

c)

> diag :: Integer -> [(Integer, Integer)]
> diag n = [(x,y) | x <- [n,n-1..0], y <- [0..n] , x + y == n]

d)

> pairs' :: [(Integer, Integer)]
> pairs' = concat (map (diag ) [0..])

e)

In theory, there is one way of solviing this problem.
The possible way is to think (0,0) as the origin. 
Like a grid, treating each coordinate as part of a concentric
circle in an infinite amount of concentric circles.

(-2, 2) (-1, 2) (0, 2) (1, 2) (2, 2)
(-2, 1) (-1, 1) (0, 1) (1, 1) (2, 2)
(-2, 0) (-1, 0) (0, 0) (1, 0) (2, 0)
(-2,-1) (-1,-1) (0,-1) (1,-1) (2,-1)
(-2,-2) (-1,-2) (0,-2) (1,-2) (2,-2)

It is possible haskell lacks the power to do this,
but it might be due to lack of knowledge on my part.
I

Question 5

> count1  :: Integer -> Int
> count1 n = length [ (i,j) | i <- [1..n], odd i, j <- [1..n], even j ]

> count2  :: Integer -> Int
> count2 n = length [ (i,j) | i <- [1..n], j <- [1..n], odd i, even j ]

a)

Even though these two functions do the same operation, 
they do differ slightly, mainly by the conditional
statements in the comprehensions, meaning count1 goes through
the i values, then the j values, checking if they ar odd/even.
The function count2 goes through values for i and j, then checks if 
i is odd and j is even. By performance, count1 is faster than count2.

b)

> count3 :: Integer -> Int
> count3 n | n `mod` 2 == 0 = x^2
>          | otherwise = (x^2) + x
>          where x = fromIntegral (n `div` 2)

0  1  2  3  4  5  6  7  8  9 10
0  0  1  2  4  6  9 12 16 20 25
  +0 +1 +1 +2 +2 +3 +3 +4 +4 +5
Assuming x is the floor of n/2.
All even n values in count return a perfect square
of x, meaning the return value is (x)^2.
All odd values have a return value of (x^2) + x.
executing the count1 function helped test this theory.


