main :: IO ()
main = do
    n <- readLn :: IO Int
    s <- readLn :: IO Int
    let ans = countPairs n s
    print ans

countPairs :: Int -> Int -> Int
countPairs n s = length [(x, y) | x <- [1..n], y <- [1..n], x + y <= s]