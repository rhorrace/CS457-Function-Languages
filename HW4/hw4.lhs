----------------------------------------------------------------------
CS457/557 Functional Languages, Winter 2019                 Homework 4

Combinatorial Conundrums!
----------------------------------------------------------------------

Due: At the start of class on February 7, 2019.

Please make sure you follow the usual guidelines for preparing and
submitting your homework assignment.  There are three parts to
this assignment.  None of them requires writing a lot of code, but
all of them require some careful thought, so make sure you start
early!  And please ask questions if you get stuck or need help or
clarification about any part of the assignment.

------------
Part 1:  Countdown!

We have spent some time in class this week reviewing "The
countdown problem" that is described in Chapter 9 from the
textbook, so it is only reasonable that we begin with some
questions based on that!

As a warm-up (Not for credit), I encourage you to work through
Exercises 1-3 in Section 9.11 of the textbook (Page 120).  Very
brief answers to these questions are included at the back of the
book, so these questions are not mandatory, and you may choose to
skip them if you wish ... but I encourage you to try them if you
have time because I think they are still useful exercises.

All of the remaining questions are "For credit".

Exercise 4.

[Hints: Be sure to include your working and, as appropriate,
details of any changes that you have made to the programs.  You
may use the countdown.lhs file that is in the github repository
for the class, as developed in Lecture 7, as your starting point,
but you should be aware that are some small differences between
that program and the version in the book.  In particular, the code
in countdown.lhs replaces the apply and valid functions from the
book with an evalOp function that also incorporates the
optimizations described in Section 9.9 (which should not be used
for this exercise).

Exercise 6b.

[Hints (which you may choose to ignore): One possible way to
approach this problem involves defining a function:

> closest :: Int -> [Int] -> Int
> closest  = error "replace this with your definition!"

such that  closest t ns  returns the integer in ns that is closest
to the target t (Or, one of the closest if there is more than one
such number in ns.)  For example:

    closest 16 [1,2,4,8,16,32,64] == 16
    closest 19 [1,2,4,8,16,32,64] == 16
    closest 26 [1,2,4,8,16,32,64] == 32
    closest 77 [1,9..100]         == 73

You do not need to worry about cases where ns is empty.

You can determine whether one number x is closer to a target value t
than another number y by checking to see if:

    abs (x - t) < abs (y - t).

For testing purposes, you may find it useful to know that there is
no exact solution to the puzzle ([10,9,3,9,2,6],688).  Perhaps you
can find some other examples?]

------------
Part 2:  Catalan Numbers and Dynamic Programming

In Week 4, Slide 26, we saw that the sequence of Catalan numbers
can be described by a function described informally as follows:

  cat      :: Int -> Integer
  cat 1     = 1
  cat (n+1) = cat n * cat 1 + cat (n-1) * cat 2 + ...
                + cat 2 * cat (n-1) + cat 1 * cat n

a) Write a simple Haskell implementation of cat and verify that it
generates the sequence of values that were shown on the slide.

> cat :: Int -> Integer
> cat  = error "replace this with your definition!"

Your implementation must be based directly on the formula above,
and not on any other method for calculating these numbers.  [Apart
from anything else, you may struggle to answer later parts of this
question if you do not follow this advice!]

b) Construct a definition for a function:

> nextcat :: [Integer] -> [Integer]
> nextcat  = error "replace this with your definition!"

that satisfies the following law (for all integers n>1):

  nextcat (catalans n) = catalans (n+1)

where:

> catalans  :: Int -> [Integer]
> catalans n = reverse (map cat [1..n])

To understand this description, note that:

    catalans 1 == [1]
    catalans 2 == [1,1]
    catalans 3 == [2,1,1]
    catalans 4 == [5,2,1,1]
    catalans 5 == [14,5,2,1,1]
    etc...

As a result, the description of nextcat given above requires that,
for example:

    nextcat [1]       = [1,1]
    nextcat [1,1]     = [2,1,1]
    nextcat [2,1,1]   = [5,2,1,1]
    nextcat [5,2,1,1] = [14,5,2,1,1]
    etc...

Note that your definition of nextcat should not use your
implementations of either cat or catalans; the challenge therefore
is to figure out how you can calculate each list in the sequence
directly from the preceding list.  You can assume that the nextcat
function will only be applied to lists of the form (catalans n)
for some n, and you do not need to include any code to check for
this.

c) Construct a definition for a function:

> fastcat :: Int -> Integer
> fastcat  = error "replace this with your definition!"

that produces the same results as, but is also demonstrably much
faster than, the original cat function (at least for larger values
of n).  [Hint: You may find it useful to revisit the Pascal's
triangle example that was demonstrated in class, and/or the
fibs.lhs example that is included in the github repository.]

d) Find the smallest value n such that the value of cat n, in
standard decimal notation, contains 300 or more digits.

------------
Part 3:  Doing the splits!

[Hint: The split/splits function that was introduced in solution
to the countdown problem/in the AUG example is likely to be *very*
useful in the following task.  To save you the trouble of looking
it up again, here is the definition from the countdown program:

> split'        :: [a] -> [([a], [a])]
> split' []     = []
> split' [n]    = []
> split' (n:ns) = ([n], ns) : [ (n:ls, rs) | (ls, rs) <- split ns ]

If you've forgotten how this function works, you are encouraged to
study the definition above and to try it on some examples before
proceeding further.]

a) There are many different ways to construct a non-empty string
using only non-empty string literals and the ++ operator.  For
example, the string "pdx" can be constructed by writing "pdx",
("p"++"dx"), or (("p"++"d")++"x") (and these are not the only
options).

Your task in this question is to define a function:

> allWays   :: String -> [String]
> allWays xs = error "replace this with your definition!"

that will produce a list of strings that show all of the possible
ways to build the given string in this way, provided that the
input is not empty.  To help you to display the output from this
function in a readable manner, you may use the following function:

> layout :: [String] -> IO ()
> layout  = putStr
>         . unlines
>         . zipWith (\n l -> show n ++ ") " ++ l) [1..]

Remember also that you can convert an arbitrary string into the
text for a corresponding string literal by applying the show
function:

  Main> show "hello"
  "\"hello\""
  Main>

For example, here is what you might see when you use allWays and
layout together in a Hugs or GHCi session:

  Main> layout (allWays "pdx")
  1) "pdx"
  2) ("p"++"dx")
  3) ("p"++("d"++"x"))
  4) ("pd"++"x")
  5) (("p"++"d")++"x")

  Main> 

It is not necessary for your solution to list the generated
strings in exactly the same order as shown in this input: If you
happen to come up with a different variation of the code that
lists them in a different order, that will be just fine.  However,
you should follow the convention used above in which parentheses
are placed around any use of the ++ operator.  You are strongly
encouraged to use the following function to help construct strings
that are in this format:

> appString    :: String -> String -> String
> appString l r = "(" ++ l ++ "++" ++ r ++ ")"

b) Of course, in practice, there is no need to include parentheses
in expressions that construct lists using the notation from (a)
above.  For example, ("p"++("d"++"x")) and (("p"++"d")++"x") are
equivalent to "p"++"d"++"x" because the ++ operator is
associative.  Your task in this question, therefore, is to write a
new function:

> noParens   :: String -> [String]
> noParens xs = error "replace this with your definition!"

that generates a list of strings showing all of the possible ways
to construct the given input list using only ++ and string
literals, without any repetition or parentheses.  For example,
here is an example showing how this function might be used in Hugs
or GHCi:

  Main> layout (noParens "pdx")
  1) "pdx"
  2) "p"++"dx"
  3) "p"++"d"++"x"
  4) "pd"++"x"

  Main>

Note that there are only 4 output lines in this particular
example, so you cannot produce the output for noParens simply by
removing the open and close parenthesis characters from the output
of allWays.  [Hint: Indeed, your definition of noParens will
probably have a different structure to your definition of allWays,
although it might still make good use of the splits function ...]

----------------------------------------------------------------------
