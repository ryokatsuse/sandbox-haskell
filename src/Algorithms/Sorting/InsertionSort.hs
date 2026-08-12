-- | 挿入ソート（CLRS 第2章「さあ始めよう」）。
--
-- CLRS の手続き的な擬似コードは配列 @A[2..n]@ を順にたどり、各要素
-- @key = A[j]@ について、ソート済みの前半 @A[1..j-1]@ を右へずらしながら
-- @key@ の入る位置を探して割り込ませる。
--
-- 以下の関数的な実装も同じ考え方をなぞる。'insert' が内側の @while@ ループ
-- そのもの（@key@ をソート済みリストに滑り込ませる）で、'insertionSort' は
-- それを入力全体に畳み込み、ソート済みの前半を1要素ずつ伸ばしていく。
module Algorithms.Sorting.InsertionSort
  ( insertionSort
  , insertionSortBy
  , insert
  ) where
--
-- >>> insertionSort [5, 2, 4, 6, 1, 3]
-- [1,2,3,4,5,6]
insertionSort :: Ord a => [a] -> [a]
insertionSort = insertionSortBy compare

-- | 比較関数を明示的に渡す挿入ソート。'Ord' インスタンスが無くても、
-- 任意の順序（降順やキー指定など）で並べ替えられる。
insertionSortBy :: (a -> a -> Ordering) -> [a] -> [a]
insertionSortBy cmp = foldr (insertBy cmp) []

-- | ソート済みリストに要素を1つ挿入する（CLRS の内側ループに相当）。
-- 結果もソート済みに保たれる。安定（stable）：等しい要素の相対順序は変わらない。
insert :: Ord a => a -> [a] -> [a]
insert = insertBy compare

insertBy :: (a -> a -> Ordering) -> a -> [a] -> [a]
insertBy _   x [] = [x]                        -- 挿入先が空なら x だけのリスト
insertBy cmp x (y : ys)
  | cmp x y == GT = y : insertBy cmp x ys      -- x が大きい間は y を残して奥へ
  | otherwise     = x : y : ys                 -- x <= y になった位置に割り込む

