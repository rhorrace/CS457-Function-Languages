{-# LANGUAGE FlexibleInstances #-}

module HW5 where
import Treedot
import Data.List

-- VizTree data structure
data VizTree = VizNode String [VizTree]
  deriving (Show)

-- Viz class definition and functions
class Viz a where
  toVizTree        :: a -> VizTree
  toVizList        :: [a] -> VizTree
  toVizList []     = VizNode "[]" []
  toVizList (x:xs) = VizNode ":" [toVizTree x, toVizTree xs]

-- an Integer insance
instance Viz Integer where
  toVizTree n = VizNode (show n) []

-- a Char instance
instance Viz Char where
  toVizTree n = VizNode (show n) []
  toVizList s = VizNode ("\\\"" ++ s ++ "\\\"") []

-- a List instance
instance Viz a => Viz [a] where
  toVizTree = toVizList
{-
  toVizTree []     = VizNode "[]" []
  toVizTree (x:xs) = VizNode ":" [toVizTree x, toVizTree xs]
-}

-- Bool instance
instance Viz Bool where
  toVizTree n = VizNode (show n) []

-- Int instance
instance Viz Int where
  toVizTree n = VizNode (show n) []

-- a Pair instance
instance Viz (Integer,Char) where
  toVizTree (x,y) = VizNode ("(" ++ show x ++ "," ++ show y ++ ")") []

-- a triple instance
instance Viz (Int,Int,Int) where
  toVizTree (x,y,z) = VizNode ("(" ++ show x ++ "," ++ show y ++ "," ++ show z ++ ")") []

-- a Maybe instance
instance Viz a => Viz (Maybe a) where
  toVizTree Nothing   = VizNode "Nothing" []
  toVizTree (Just _)  = VizNode "Just" []

-- Instances for vizTree to be able to
-- write to a dot file.
instance Tree (VizTree) where
  subtrees (VizNode _ []) = []
  subtrees (VizNode _ ts) = ts

instance LabeledTree (VizTree) where
  label (VizNode s _) = s
 
-- Write VizTree to dot file
viz :: Viz a => a -> IO()
viz = writeFile "tree.dot" . toDot . toVizTree
