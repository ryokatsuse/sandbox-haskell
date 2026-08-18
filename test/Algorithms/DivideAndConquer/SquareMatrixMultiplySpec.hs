module Algorithms.DivideAndConquer.SquareMatrixMultiplySpec (spec) where

import Test.Hspec
import Test.QuickCheck

import Algorithms.DivideAndConquer.SquareMatrixMultiply
  ( squareMatrixMultiply
  , squareMatrixMultiplyRecursive
  )

-- 2の累乗サイズの正方行列をランダムに生成する（分割統治版の前提を満たすため）。
genPow2SquareMatrix :: Gen [[Int]]
genPow2SquareMatrix = do
  k <- elements [0, 1, 2, 3 :: Int]
  let n = 2 ^ k
  vectorOf n (vectorOf n (choose (-10, 10)))

spec :: Spec
spec = do
  describe "squareMatrixMultiply" $
    it "multiplies the CLRS 2x2 example" $
      squareMatrixMultiply [[1, 2], [3, 4]] [[5, 6], [7, 8 :: Int]]
        `shouldBe` [[19, 22], [43, 50]]

  describe "squareMatrixMultiplyRecursive" $ do
    it "multiplies the CLRS 2x2 example" $
      squareMatrixMultiplyRecursive [[1, 2], [3, 4]] [[5, 6], [7, 8 :: Int]]
        `shouldBe` [[19, 22], [43, 50]]

    it "agrees with the definition-based multiply (property)" $
      forAll genPow2SquareMatrix $ \a ->
        forAll genPow2SquareMatrix $ \b ->
          length a == length b
            ==> squareMatrixMultiplyRecursive a b == squareMatrixMultiply a b
