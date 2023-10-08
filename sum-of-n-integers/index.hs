main :: IO ()
main = do
  n <- readLn
  print $ sum [1..n]