Robert Horrace
CS 457

Question 1

Fractals.lhs was modified and PPMs were created for this problem.

Question 2

> dup    :: (a -> a -> a) -> a -> a
> dup f x = f x x

> double  :: Integer -> Integer
> double n = dup (+) n

Examples:
double 2
4
double 3
6
double 4
8

> square  :: Integer -> Integer
> square n = dup (*) n

Examples:
square 2
4
square 3
9
square 4
16

Question 3

> powerOfTwo :: Int -> Integer
> powerOfTwo n = last (take (n+1) (iterate (2*) 1))

Examples:
powerOfTwo 0
1
powerOfTwo 1
2
powerOfTwo 8
256

> logTwo :: Integer -> Int
> logTwo v = length (takeWhile (v >=) (map (powerOfTwo) l))
>          where l = [0..fromIntegral (v-1)]

Examples:
logTwo 1
1
logTwo 2
2
logTwo 3
2
logTwo 4
3
logTwo 5
3
logTwo 6
3
logTwo 7
3
logTwo 8
4

> copy :: Int -> a -> [a]
> copy n x = take n (repeat x)

Examples:
copy 5 4
[4,4,4,4,4]
copy 5 0
[0,0,0,0,0]
copy 0 5
[]

> multiApply :: (a -> a) -> Int -> a -> a
> multiApply f n x = last (take (n+1) (iterate f x))

Examples:
multiApply (2+) 1 1
3
multiApply (2+) 2 1
5
multiApply (2+) 1 2
4
multiApply (2+) 2 2
6

> q f n m x = multiApply (multiApply f n) m x

Answer:

The function is a function type of (a -> a) -> int -> int -> a -> a,
the function takse a function f of type (a -> a), two Int variables n and m, and a variable x of type a, returning a value of type a.

the function q takes the parameters f, m, m, and x, and uses the defined multiApply function, using multiApply, f, and n as the function parameter of the outer multiApply, and using mand x as the other parameters. 

Question 4

> revindex :: [a] -> Int -> a
> revindex xs n = (reverse xs) !! n

Examples:

[1..10] !! 2
3
revindex [1..10] 7
3

[1..100] !! 49
50
revindex [1..100] 49
50

Question 5

The twirl function calculates the reverse of the tail. The function notnull determines of a list is not empty, returning true or false depending on the list.The strange function takes a list and returns the relative middle of a list. If we have a list that is [1..10], the result is 6, if it is [1..9], 5 is returned, and [1..11] returns a 6. If the list's length is even, then the element to the right of the relative middle is returned, otherwise the exact middle. 

> strange xs = xs !! (length xs `div` 2) 

Examples:
strange [1..10]
6
strange [1..11]
6
strange [1..9]
5
