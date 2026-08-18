-- | 正方行列の積（CLRS 第4章 4.1節・4.2節）。
--
-- 4.1節の @SQUARE-MATRIX-MULTIPLY@ は定義通りに @c_ij = Σ_k a_ik * b_kj@
-- を計算する O(n^3) のアルゴリズム。4.2節では、これを分割統治で書き直す：
-- n×n の行列を n\/2 × n\/2 の4つの部分行列に分割し、
--
-- >   C11 = A11*B11 + A12*B21     C12 = A11*B12 + A12*B22
-- >   C21 = A21*B11 + A22*B21     C22 = A21*B12 + A22*B22
--
-- という8回の部分行列積（＋4回の加算）で再帰的に求める。計算量は
-- T(n) = 8T(n\/2) + Θ(n^2) となり、定義通りの計算と同じ Θ(n^3) になる
-- （Strassen法はこの8回を7回に減らすことで Θ(n^2.81) を達成するが、
-- ここでは扱わない）。
--
-- この分割統治版は、行列のサイズ n が2の累乗であることを前提とする
-- （CLRS 本文の単純化と同じ）。
module Algorithms.DivideAndConquer.SquareMatrixMultiply
  ( Matrix
  , squareMatrixMultiply
  , squareMatrixMultiplyRecursive
  ) where

import Data.List (transpose)

-- | 正方行列を行のリストとして表す（各行は列の値のリスト）。
type Matrix a = [[a]]

-- | 定義通りに正方行列の積を計算する（CLRS の @SQUARE-MATRIX-MULTIPLY@）。
-- 分割統治版と違い、サイズに2の累乗という制約はない。
--
-- >>> squareMatrixMultiply [[1,2],[3,4]] [[5,6],[7,8]]
-- [[19,22],[43,50]]
squareMatrixMultiply :: Num a => Matrix a -> Matrix a -> Matrix a
squareMatrixMultiply a b =
  [ [ sum (zipWith (*) row col) | col <- transpose b ] | row <- a ]

-- | 分割統治で正方行列の積を計算する（CLRS 4.2節）。
-- 行列を4つの部分行列に分割し、8回の部分行列積と4回の行列加算で
-- 結果を組み立てる。サイズ n は2の累乗であることを前提とする。
--
-- >>> squareMatrixMultiplyRecursive [[1,2],[3,4]] [[5,6],[7,8]]
-- [[19,22],[43,50]]
squareMatrixMultiplyRecursive :: Num a => Matrix a -> Matrix a -> Matrix a
squareMatrixMultiplyRecursive [[x]] [[y]] = [[x * y]]
squareMatrixMultiplyRecursive a b = combine c11 c12 c21 c22
  where
    (a11, a12, a21, a22) = split a
    (b11, b12, b21, b22) = split b

    c11 = squareMatrixMultiplyRecursive a11 b11 `addM` squareMatrixMultiplyRecursive a12 b21
    c12 = squareMatrixMultiplyRecursive a11 b12 `addM` squareMatrixMultiplyRecursive a12 b22
    c21 = squareMatrixMultiplyRecursive a21 b11 `addM` squareMatrixMultiplyRecursive a22 b21
    c22 = squareMatrixMultiplyRecursive a21 b12 `addM` squareMatrixMultiplyRecursive a22 b22

-- | 正方行列を左上・右上・左下・右下の4つの部分行列に分割する。
split :: Matrix a -> (Matrix a, Matrix a, Matrix a, Matrix a)
split m = (a11, a12, a21, a22)
  where
    half          = length m `div` 2
    (top, bottom) = splitAt half m
    a11           = map (take half) top
    a12           = map (drop half) top
    a21           = map (take half) bottom
    a22           = map (drop half) bottom

-- | 4つの部分行列を1つの行列に組み立てる（'split' の逆操作）。
combine :: Matrix a -> Matrix a -> Matrix a -> Matrix a -> Matrix a
combine a11 a12 a21 a22 = zipWith (++) a11 a12 ++ zipWith (++) a21 a22

-- | 2つの行列の要素ごとの和。
addM :: Num a => Matrix a -> Matrix a -> Matrix a
addM = zipWith (zipWith (+))
