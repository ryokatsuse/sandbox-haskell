module Main (main) where

import Algorithms.Sorting.InsertionSort (insertionSort)

main :: IO ()
main = do
  let xs = [5, 2, 4, 6, 1, 3] :: [Int]
  putStrLn "== Insertion Sort (CLRS ch.2) =="
  putStrLn $ "input:  " ++ show xs
  putStrLn $ "sorted: " ++ show (insertionSort xs)
