factorize :: Int -> [Int]
factorize n = factorizeHelper n 2
    where
        factorizeHelper 1 _ = []
        factorizeHelper n f
            | n `mod` f == 0 = f: factorizeHelper (n `div` f) f
            | otherwise = factorizeHelper n (f + 1)

main :: IO ()
main = print $ factorize 456
