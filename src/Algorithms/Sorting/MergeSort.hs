-- | マージソート（CLRS 第2章 2.3節）。
--
-- CLRS の手続き的な擬似コードはリストを半分に分割し、それぞれを再帰的に
-- ソートしてから、2つのソート済み部分列を先頭から見比べてマージする。
--
-- 以下の関数的な実装も同じ考え方をなぞる。'merge' が @MERGE@ 手続き
-- そのもの（2つのソート済みリストを1つに統合する）で、'mergeSort' は
-- リストを半分に分割し、それぞれを再帰的にソートしてから 'merge' で統合する。
module Algorithms.Sorting.MergeSort
  ( mergeSort
  , mergeSortBy
  , merge
  ) where

-- | リストをマージソートで非減少順（小さい順）に並べ替える。
--
-- >>> mergeSort [5, 2, 4, 6, 1, 3]
-- [1,2,3,4,5,6]
mergeSort :: Ord a => [a] -> [a]
mergeSort = mergeSortBy compare

-- | 比較関数を明示的に渡すマージソート。'Ord' インスタンスが無くても、
-- 任意の順序（降順やキー指定など）で並べ替えられる。
mergeSortBy :: (a -> a -> Ordering) -> [a] -> [a]
mergeSortBy _   []  = []
mergeSortBy _   [x] = [x]
mergeSortBy cmp xs  = mergeBy cmp (mergeSortBy cmp left) (mergeSortBy cmp right)
  where  
    (left, right) = splitAt (length xs `div` 2) xs

-- | 2つのソート済みリストを1つのソート済みリストに統合する
-- （CLRS の @MERGE@ 手続きに相当）。安定（stable）：等しい要素は
-- 左側のリストの要素が先になる。
merge :: Ord a => [a] -> [a] -> [a]
merge = mergeBy compare

mergeBy :: (a -> a -> Ordering) -> [a] -> [a] -> [a]
mergeBy _   []       ys       = ys
mergeBy _   xs       []       = xs
mergeBy cmp (x : xs) (y : ys)
  | cmp x y == GT = y : mergeBy cmp (x : xs) ys  -- yの方が小さいのでyを先に出す
  | otherwise     = x : mergeBy cmp xs (y : ys)  -- xがy以下ならxを先に出す
