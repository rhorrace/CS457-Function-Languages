----------------------------------------------------------------------
CS457/557 Functional Languages, Winter 2019                 Homework 3

Simple arbitrary precision bit arithmetic
----------------------------------------------------------------------

Due: At the start of class on January 31, 2019.

Please make sure you follow the usual guidelines for preparing and
submitting your homework assignment, and please ask questions if
you get stuck or need help or clarification about any part of the
assignment.  There are five parts to this assignment, labeled (a)
to (e) below.

------------
NOTES:

1) The primary purpose for this set of exercises is to give you
   some practice in writing function definitions that use features
   like: multiple equations; pattern matching; recursion; guards;
   where clauses; etc...  That said, there are no points on the
   grading scheme specifically for using these features, so if you
   find other ways to answer the questions that don't use some or
   all of these features, that's ok ... so long as they still work
   correctly!]

2) I have used the following expression:

       error "replace with your code!"

   at a number of points in ths following definitions; by the time
   you have finished this assignment, you should have replaced all
   of those expressions (including both the error function and the
   string that follows it) with appropriate expressions.  Or
   perhaps you will have rewritten those function definitions
   completely in a different style, depending on how you like to
   tackle these exercises.   The only reason for using the
   expression here is so that you can load this file in to Hugs or
   ghci, even when you are still working on your answers; if we
   had just left those parts of the code blank instead, then the
   interpreters would report a syntax error instead.]

------------
Introduction:

Consider the following definition of a datatype of bits:

> data Bit = O | I    deriving Show

This datatype has two different values, written O and I, which
we will use to represent the bits 0 and 1.  (Make sure you are
using the capital letters O and I for Bit values, and not the
numeric digits 0 and 1, or else you will see some puzzling error
messages!) We'll talk more about the "deriving Show" part of
this declaration in class soon, but for now you can just treat
it as an indication that we want to be able to print out values
of the Bit type, as in the following example:

  Main> [I, O, I, O, I, I]
  [I,O,I,O,I,I]
  Main>

Now we can define a type of binary numbers:

> type BinNum = [Bit]

For convenience, we'll assume that the least significant bit is
stored at the head of the list so that, for example, [O, O, I]
represents the number 4 and [O, I, I, O, I, O] represents 22.

As an example, we will provide a function for testing to see if
two BinNum values are equal; we'll see soon that Haskell has a
way of generating functions like this automatically.  But for
the purposes of this exericse, we'll go a little further and
define a function that also ignores "leading zeros" (which, with
our representation here, actually appear at the end of the list).
For example, the BinNum values [I, O] and [I] are clearly not
equal as lists, but they both represent the same number (one),
and hence are treated as being equal by the eq function:

> eq              :: BinNum -> BinNum -> Bool
> eq (O:xs) (O:ys) = eq xs ys
> eq (I:xs) (I:ys) = eq xs ys
> eq []     ys     = isZero ys
> eq xs     []     = isZero xs
> eq xs     ys     = False

Note that it is possible that one of the two numbers that we
are comparing has more digits than the other: in those situations,
the code above makes use of the following helper function to check
that a BinNum value contains only O values:

> isZero :: BinNum -> Bool
> isZero  = all isO
>  where isO O = True
>        isO I = False

[Note: The expression (all p xs) returns True if, and only if
all of the list elements in xs satisfy the predicate p.  The
all function used here is defined in the standard prelude as:
all p = and . map p.]

------------
a) Study the definition for eq carefully to make sure that you
understand how it works.  Write some simple test cases to verify
that it is working correctly (do not use empty lists in any of
your test cases; they are not considered as valid BinNum values
because they do not contain any digits).  You are not expected to
perform any automated testing at this point: that would be
difficult because we do not yet have any automatic way of
generating BinNum values.  What is the smallest number of test
cases that you need to make sure that every line in the
definitions of eq and isZero (together) is tested at least one
time?

------------
b) Define functions:

> toBinNum   :: Integer -> BinNum
> fromBinNum :: BinNum -> Integer

that convert backwards and forwards between Integers and their
corresponding BitNum representations.

You are welcome to construct your definitions of these functions
in any way, but if you are not sure where to start, then the
following templates may give you some ideas:

> toBinNum n | n==0   = error "replace with your code!"
>            | even n = error "replace with your code!"
>            | odd n  = error "replace with your code!"
>              where halfOfN = n `div` 2

> fromBinNum []     = error "replace with your code!"
> fromBinNum (O:ds) = error "replace with your code!"
> fromBinNum (I:ds) = error "replace with your code!"

If you prefer to approach these problems in a different way (for
example, avoiding recursion), that's fine (and a good exercise
too, by the way).

------------
c) Define a BinNum increment function

> inc :: BinNum -> BinNum
> inc  = error "replace with your code!"

without using either toBinNum or fromBinNum, that satisfies the
law:    inc . toBinNum = toBinNum . (1+)

For example, inc [I,I,O,I,O,I] should yield [O,O,I,I,O,I]

Hint: pattern matching and recursion should work together nicely
for you here ...

------------
d) Define a function

> add :: BinNum -> BinNum -> BinNum

that computes the sum of its arguments. More formally, your add
function should satisfy the following law:

    add x y = toBinNum (fromBinNum x + fromBinNum y)

Note, however, that your implementation of add should not make any
use of Integer values.

Hint: You might like to look for a definition that uses pattern
matching on two arguments, together with a little bit of
recursion.  Something like the following might be a good start:

>  add []     ds     = error "replace with your code!"
>  add ds     []     = error "replace with your code!"
>  add (O:ds) (e:es) = error "replace with your code!"
>  add (I:ds) (O:es) = error "replace with your code!"
>  add (I:ds) (I:es) = error "replace with your code!"

But this is not the only possible approach, so feel free to
explore other options ...

[Note: An efficient implementation of add should perform at most
one pattern match per digit of the input numbers.  You will not be
penalized if your implementation does not satisfy this property,
but, if you are interested and have a little time play, then I
encourage you to see if you can find such an implementation.  As a
hint, the main challenge will be to incorporate some notion of a
"carry" bit that you might also use if you were doing a long
addition like this by hand/on paper.]

------------
e) Define a function:

> mult :: BinNum -> BinNum -> BinNum
> mult = error "replace with your code!"

that computes the product of its arguments (without converting
them to Integer values first).  If you're not sure how to proceed,
you might want to try reminding yourself about long multiplication
and the see if you can adapt those ideas to this problem.

Write a law to specify its behavior in relation to the (*)
operator on Integer values, and show that your implementation
satisfies that law.

Hint: I'm not going to provide you with a template this time ---
you should have seen enough of those by now to construct one for
yourself. And don't forget that we've already defined some useful
functions like inc and add for doing arithmetic on BinNum values;
perhaps one of those will be useful to you here ...

----------------------------------------------------------------------
