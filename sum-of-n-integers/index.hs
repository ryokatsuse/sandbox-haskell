main :: IO ()
main = do
    _ <- getLine
    numsLine <- getLine
    let nums = map read $ words numsLine :: [Int]
    let sumNums = sum nums
    print sumNums