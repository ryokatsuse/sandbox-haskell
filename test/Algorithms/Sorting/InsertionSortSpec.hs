module Algorithms.Sorting.InsertionSortSpec (spec) where

import Data.List (sort)
import Test.Hspec
import Test.QuickCheck

import Algorithms.Sorting.InsertionSort (insertionSort)

spec :: Spec
spec = describe "insertionSort" $ do
  it "sorts the CLRS example" $
    insertionSort [5, 2, 4, 6, 1, 3 :: Int] `shouldBe` [1, 2, 3, 4, 5, 6]

  it "leaves the empty list unchanged" $
    insertionSort ([] :: [Int]) `shouldBe` []

  it "agrees with Data.List.sort (property)" $
    property $ \xs -> insertionSort xs == sort (xs :: [Int])

  it "is idempotent: sorting a sorted list is a no-op (property)" $
    property $ \xs ->
      let s = insertionSort (xs :: [Int]) in insertionSort s == s

  it "output is a permutation of the input (property)" $
    property $ \xs -> sort (insertionSort xs) == sort (xs :: [Int])
