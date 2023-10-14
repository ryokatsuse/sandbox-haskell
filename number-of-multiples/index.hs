-- 最大公約数の計算
gcd' :: Int -> Int -> Int
gcd' x 0 = x
gcd' x y = gcd' y (x `mod` y)

-- 最小公倍数の計算
lcm' :: Int -> Int -> Int
lcm' x y = abs(x*y) `div` gcd' x y

-- 2つの整数のリストの最小公倍数を計算する
countMultiples :: Int -> Int -> Int -> Int
countMultiples n x y =
    n `div` x + n `div` y - n `div` (lcm' x y)

main :: IO ()
main = do
    putStrLn "N以下の整数の中で、何の倍数の数を調べますか？"
    putStrLn "Nを入力してください："
    n <- read <$> getLine

    putStrLn "Xの倍数を調べたい場合、Xを入力してください："
    x <- read <$> getLine

    putStrLn "Yの倍数を調べたい場合、Yを入力してください："
    y <- read <$> getLine

    print $ countMultiples n x y  -- 結果を表示