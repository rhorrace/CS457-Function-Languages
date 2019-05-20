----------------------------------------------------------------------
CS457/557 Functional Languages, Winter 2019                 Homework 2
----------------------------------------------------------------------

This is a literate Haskell script that can be loaded directly in a
Haskell interpreter like hugs or ghci.

> import Data.List

----------------------------------------------------------------------
Reading: Read Chapters 3-7 from the textbook (up to, but not
including Section 7.6) to reinforce the key topics we've talked
about this past week (and for some peeks at additional topics that
we'll be covering in the coming weeks.   You may choose to skim
(or even skip) the material about the "Caesar cipher" in Section
5.5: I will not expect you to be familiar with the specifics as we
move forward.  That said, it's entertaining, and does provide more
examples of Haskell coding that you might find useful, so I think
it's worth a look if you have time.  You are also encouraged to
use the exercises in these chapters to test your understanding,
but only the specific questions listed below will be required for
credit.  The chapters are fairly short and clear, and I think you
will find them to be helpful!  (We're also happy to take questions
on any parts of this text if you need additional clarification.)

----------------------------------------------------------------------
For Credit Exercises:  Your solutions to the following questions
are due at the start of class (noon) on January 24 in person.
There will be a dropbox for submissions on D2L but submission in
person/on paper is strongly preferred if possible.  (And note that,
if you do submit via the dropbox then: (a) the submission must be
a single file in either plain text or pdf format; and (b) grading
may be delayed until we are able to print your file, or feedback
may be limited if we grade online.)

Please follow the same general guidelines that were provided for
Homework 1 (and in the course syllabus).  In particular, be sure
to include appropriate explanations and justification to accompany
your answers!

----------------------------------------------------------------------
Exercises from the textbook:
----------------------------
Chapter 5 (P57-58): Question 6.
Chapter 6 (P72): Question 7.

----------------------------------------------------------------------
Additional exercises:
---------------------
Question 1:
-----------
Give possible types (not involving any type variables) for each
of the following expressions (or else explain why you think the
expression is ill-typed).
 a) map even
 b) takeWhile not
 c) ([]++)
 d) (:[])
 e) ([]:)
 f) [ [], [[]], [[[]]], [[[[]]]], [[[[[    ]]]]] ]
 g) [ [], [[]], [[[]]], [[[[]]]], [[[[[True]]]]] ]
 h) [ [True], [[]], [[[]]], [[[[]]]], [[[[[]]]]] ]
 i) map map
 j) map (map even)
 k) map . map
 l) (map , map)
 m) [ map id, reverse, map not ]

You may use hugs or ghci to help you answer these questions, but
beware that these systems will always try to display the most
general types possible, which could involve type variables, so you
may need to make some adjustments to the types that they display.

----------------------------------------------------------------------
Question 2:
-----------
Explain what each of the following functions does.  Note that
your answers should reflect the behavior of each function at a
high-level and should not just be a restatement of the Haskell
syntax.  For example, you could say that (sum . concat) is a
function that "adds up all of the values in a list of list of
numbers", but you wouldn't get credit for saying that it is "the
composition of the sum and concat functions".

 a) even . (1+)
 b) even . (2*)
 c) ([1..]!!)
 d) (!!0)
 e) reverse . reverse
 f) reverse . tail . reverse
 g) map reverse . reverse . map reverse

----------------------------------------------------------------------
Question 3:
-----------
One of the more puzzling laws that we have seen in class is the
following:

    concat . concat  =  concat . map concat

The purpose of this question is to help you understand why this
law is valid.

a) What are the types of the functions on the left and right hand
sides of the law above?

b) As a special case, consider the following list value:

> xsss = [ [[1], [2, 3]], [[4]], [[5], [6]] ]

Explain the results that you get when you use this list as an
argument to the functions on the left and right hand sides of the
law above.  Your answer should show intermediate steps in the
calculations in the style of the examples of pipelines on Slides
17 and 64 of the Week 2 slides.

c) Your answer to (b) should show that the two functions produce
the same final result when applied to the argument xsss.  How
would you characterize the key difference in the way that the two
calculations ultimately reach the same final result?

----------------------------------------------------------------------
Question 4:
-----------
For this question, you'll need know about the function elem, which
is defined in the standard prelude, and which can be used to test
if a given value is a member of a particular list.  For example:

-  elem 4 [1..10]  and  elem 5 [-10..10]  both return True
-  elem 0 [1..10]  and  elem 5 [2,4..100] both return False

a) Your first task is to modify the following definition so that
the symbol integers represents the list of all Integer values,
both positive and negative:

> integers :: [Integer]
> integers  = [0..]

Specifically, once you have modified the definition, you should be
able to guarantee that  elem n integers  will return True for any
integer value n.  [Hint: With a little investigation, you should
be able to verify that this already works if n>=0, but how can you
make sure it also works if n<0?]

b) Now suppose that we want to produce a list called pairs such
that  elem (n,m) pairs  will return True for any non-negative
integer values n and m.  Explain why the following definition is
insufficient:

> pairs :: [(Integer, Integer)]
> pairs  = [ (n,m) | n <- [0..], m <- [0..] ]

c) One way to start exploring the problem described in (b) is to
write the pairs that we want to include in the list in a table
where all the items in row i have i as their first component and
all of the items in column j have j as their second component.
The resulting table should look something like the following:

    (0, 0)   (0, 1)   (0, 2)   (0, 3)   (0, 4)   ....
    (1, 0)   (1, 1)   (1, 2)   (1, 3)   (1, 4)   ....
    (2, 0)   (2, 1)   (2, 2)   (2, 3)   (2, 4)   ....
    (3, 0)   (3, 1)   (3, 2)   (3, 3)   (3, 4)   ....
    (4, 0)   (4, 1)   (4, 2)   (4, 3)   (4, 4)   ....
    :        :        :        :        :
    :        :        :        :        :

Instead of reading this table as a set of rows and columns, think
about it as a set of "diagonals".  For example, [(0,0)] is a very
simple diagonal that cuts across the top left corner of the table;
[(1, 0), (0, 1)] is the next diagonal and it contains all of the
elements whose components add up to 1; [(2, 0), (1, 1), (0, 2)] is
the next diagonal and it contains all of the pairs whose
components add up to 2; and so on.

Complete the following function definition so that it takes an
integer n as input and returns a list of all the pairs on the
diagonal whose sum is n:

> diag  :: Integer -> [(Integer, Integer)]
> diag n = error "replace this right hand side!"

d) Using your definition of diag, construct a new definition for
pairs and show that it satisfies the property described in (b).

e) In Parts (b)-(d), we we worked only with non-negative integers.
Is it possible construct a definition of pairs that includes all
pairs (n, m) of integer values where n and m may be either
positive, zero, or negative?  As always, be sure to justify your
answer!

----------------------------------------------------------------------
Question 5:
-----------
Two friends are trying to calculate the number of distinct pairs
of the form (i, j) where i and j are integers in the range 1 to n
with i even and j odd.  Both decide to capture their solutions in
the form of Haskell programs.  Their solutions are similar, but
not quite the same:

> count1  :: Integer -> Int
> count1 n = length [ (i,j) | i<-[1..n], odd i, j<-[1..n], even j ]

> count2  :: Integer -> Int
> count2 n = length [ (i,j) | i<-[1..n], j<-[1..n], odd i, even j ]

a) How would you compare these two definitions?  In what ways are
they equivalent?  In what ways do they differ?

b) Give an alternative solution to the friends' problem, still
using Haskell, that does not require the use of any list values.
Be sure to justify your answer!

----------------------------------------------------------------------
