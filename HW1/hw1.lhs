----------------------------------------------------------------------
CS457/557 Functional Languages, Winter 2019                 Homework 1
----------------------------------------------------------------------

This is a literate Haskell program that can be loaded directly in a
Haskell interpreter like hugs or ghci.

----------------------------------------------------------------------
Reading: Reach Chapters 1 and 2 from the textbook (and Chapter 3 if
you already have a copy of the book, otherwise plan to read Chapter 3
as soon as you get a copy).  Test your understanding by working
through the exercises at the end of each chapter; in most cases, the
solutions are included at the end of the book.  You are not expected
to turn in your solutions to the exercises from Chapters 1 and 2, but
it I am happy to have discussions about these in the D2L discussion
forums, or during class time if there is sufficient interest.  Note
that some of these exercises ask you to define new functions like
"product", "last", or "init" ... but those particular functions are
already defined in the standard prelude, so you will get an error if
you try to define a new version.  In these cases, you can just pick a
different name, such as "product1", "mylast", or "otherinit".

You are also encouraged to make an initial pass through the "Notes on
Haskell" that are provided in the "Course Information" section on D2L.
You are not expected to understand everything in those notes at this
stage, but you may find details in there that will help you with the
rest of this assignment.

----------------------------------------------------------------------
For Credit Exercises:  Your solutions to the following questions are
due at the start of class (noon) on January 17.

As general guidelines for your solution:

(a) Make sure that your name appears at the top of the first page.

(b) Do not include unnecessary text (e.g., the text of the questions
    and the general instructions) so that you avoid printing out more
    material than is actually needed.

(c) Be sure to include examples of testing, and appropriate
    explanations for your answers, as necessary.  For example, the
    following text shows a quick interaction with Hugs:

      Main> (1+(2+3), (1+2)+3)
      (6,6)
      Main>

    This particular example illustrates the associativity of addition,
    at least in one particular case, because the two components of the
    resulting pair are the same, even though they are written using
    different orders of operation.  [Note how this example highlights
    a specific test case, shows the result, and then reflects on
    properties of interest that are illustrated by this particular
    test.]

The above are general requirements for all assignments, even if it is
not stated explicitly (as is likely in future weeks).  (We will be
flexible in interpreting guidelines (b) and (c) for this week so that
you have a chance to see more examples of the kinds of answers that
we are expecting.)

Here is a brief reminder about some of the functions that we have
discussed in class, which may be useful as you work to complete
this set of exercises (but you are also welcome to use other
functions mentioned in class but not listed here):

- null :: [a] -> Bool   returns True if it is applied to an empty
  list and False otherwise.  For example null [] is True, while
  null [1,2,3] is False.

- head :: [a] -> a returns the first value in a nonempty list.  For
  example, head [1,2,3,4] is 1.

- tail :: [a] -> [a] returns the input list but with its first element
  removed.  For example, tail [1,2,3,4] is [2,3,4].

- takeWhile :: (a -> Bool) -> [a] -> [a], returns all of the values at
  the front of the input list that satisfy the predicate argument.
  For example, takeWhile even [2,4,8,11,12,20] returns [2,4,8].
  while takeWhile even [1..10] returns [].

- iterate :: (a -> a) -> a -> [a],  returns a list obtain by
  repeatedly applying the function of type (a -> a) to the argument
  of type a.  The resulting list will continue for arbitrarily many
  elements, so you will likely need to use iterate in conjuction
  with a function like "take" or an operator like "!!".

----------------------------------------------------------------------
Question 1:
-----------
Experiment with the fractal program that we constructed in class (you
can use one of the versions that is available from github; see the
details at the top of the "Course Information" section on D2L).  Your
goal is to produce a new and attractive fractal image, no bigger than
a page, by modifying some (or all) of the parameters such as the range
of points, the size of the grid, the characters in the palette, or
even the fractal function.   Every student should submit a different
image.  Be sure to describe the changes that you've made.  The purpose
of this question is to make sure that you understand how the fractal
program works, and that you are comfortable modifying and running it
in some non-trivial ways.  So make sure that you achieve those goals,
but don't spend too long on this question (although I might give an
"artistic" award to the person whose fractal image seems "prettiest"
and/or most unusual to me ...  :-)

----------------------------------------------------------------------
Question 2:
-----------
Explain what the following Haskell function does:

> dup    :: (a -> a -> a) -> a -> a
> dup f x = f x x

Now consider the following two functions, and show how each of them
can be rewritten using dup:

> double  :: Integer -> Integer
> double n = 2 * n

> square  :: Integer -> Integer
> square n = n * n

----------------------------------------------------------------------
Question 3:
-----------
Without using any explicit recursion, give Haskell definitions for
the following functions:

> powerOfTwo :: Int -> Integer
> powerOfTwo  = error "delete this line and add a proper definition"

  (powerOfTwo n) returns the value of 2 to the power n.  For example,
  powerOfTwo 8 should return 256.  Of course, your answer should *not*
  use the built in Haskell functions for raising a value to a power :-)

> logTwo :: Integer -> Int
> logTwo  = error "delete this line and add a proper definition"

  (logTwo v) returns the smallest integer n such that v <= powerOfTwo n.
  [To put it another way, (logTwo v) returns the number of bits that are
  needed to represent any integer between 0 and v-1.]

> copy :: Int -> a -> [a]
> copy  = error "delete this line and add a proper definition"

  (copy n x) returns a list containing n copies of the value x.  For
  example, copy 3 True should give [True, True, True].  (The Haskell
  prelude includes a similar function called replicate; of course, you
  should not use replicate in your answer; you should not replicate
  replicate either :-)

> multiApply :: (a -> a) -> Int -> a -> a
> multiApply  = error "delete this line and add a proper definition"

  (multiApply f n x)  returns the value that is obtained when the
  function f is applied n times to the value x.  For example,
  multiApply square 2 2, should return 16, while
  multiApply not 0 True will return True.

Now suppose that we define the following function using multiApply:

> q f n m x = multiApply (multiApply f n) m x

What is the type of this function, and what exactly does it do?

----------------------------------------------------------------------
Question 4:
-----------
The Haskell prelude includes an operator !! for selecting a numbered
element of the list, with the first element starting at index 0.  For
example, [1..10] !! 0 is 1, while [1..10] !! 7 is 6.  Give a
definition for a Haskell function revindex that performs the same
indexing function as (!!) except that it starts counting from the end
of the input list.  For example, revindex [1..10] 0 should return 10,
while revindex [1..10] 7 whould return 3.

----------------------------------------------------------------------
Question 5:
-----------
Consider the following fragment of Haskell code:

> strange xs = head (head (reverse (takeWhile notnull (iterate twirl xs))))
> notnull xs = not (null xs)
> twirl xs   = reverse (tail xs)

Explain carefully what the function does.  You may want to type this
code in to a Hugs script and try running tests or using the :t command
to provide clues.  Can you suggest an alternative definition for
strange that is more efficient, more concise, and also easier to
understand?

----------------------------------------------------------------------
