-- | Insertion sort (CLRS, Chapter 2 \"Getting Started\").
--
-- The imperative CLRS pseudocode walks @A[2..n]@ and, for each @key = A[j]@,
-- shifts the already-sorted prefix @A[1..j-1]@ right until @key@ fits.
--
-- The functional formulation below mirrors that idea: 'insert' is exactly the
-- inner @while@ loop (slide @key@ into a sorted list), and 'insertionSort'
-- folds it over the input, growing a sorted prefix one element at a time.
module Algorithms.Sorting.InsertionSort
  ( insertionSort
  , insertionSortBy
  , insert
  ) where

-- | Sort a list into non-decreasing order using insertion sort.
--
-- >>> insertionSort [5, 2, 4, 6, 1, 3]
-- [1,2,3,4,5,6]
insertionSort :: Ord a => [a] -> [a]
insertionSort = insertionSortBy compare

-- | Insertion sort with an explicit comparison, so callers can sort by any
-- ordering (descending, by key, etc.) without an 'Ord' instance.
insertionSortBy :: (a -> a -> Ordering) -> [a] -> [a]
insertionSortBy cmp = foldr (insertBy cmp) []

-- | Insert an element into an already-sorted list (the CLRS inner loop),
-- keeping the result sorted. Stable: equal elements keep their relative order.
insert :: Ord a => a -> [a] -> [a]
insert = insertBy compare

insertBy :: (a -> a -> Ordering) -> a -> [a] -> [a]
insertBy _   x [] = [x]
insertBy cmp x (y : ys)
  | cmp x y == GT = y : insertBy cmp x ys
  | otherwise     = x : y : ys
