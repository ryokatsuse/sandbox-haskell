module Algorithms.Sorting.MergeSortSpec (spec) where

import Data.List (sort)
import Test.Hspec
import Test.QuickCheck

import Algorithms.Sorting.MergeSort (mergeSort)

spec :: Spec
spec = describe "mergeSort" $ do
  it "sorts the CLRS example" $
    mergeSort [5, 2, 4, 6, 1, 3 :: Int] `shouldBe` [1, 2, 3, 4, 5, 6]

  it "leaves the empty list unchanged" $
    mergeSort ([] :: [Int]) `shouldBe` []

  it "agrees with Data.List.sort (property)" $
    property $ \xs -> mergeSort xs == sort (xs :: [Int])

  it "is idempotent: sorting a sorted list is a no-op (property)" $
    property $ \xs ->
      let s = mergeSort (xs :: [Int]) in mergeSort s == s

  it "output is a permutation of the input (property)" $
    property $ \xs -> sort (mergeSort xs) == sort (xs :: [Int])
