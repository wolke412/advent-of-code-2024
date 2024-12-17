module Main where

import System.IO (readFile)
import Data.List (words, sort)
import Text.Read (read)

--  // 

file1 :: FilePath
file1 = "../assets/input_1.txt"

file2 :: FilePath
file2 = "../assets/input_2.txt"

input :: FilePath -> IO [String]
input p = readFile p >>= return . lines


main :: IO ()
main = do
    putStrLn "Reading input file 1:"
    flines <- input file1
    
    print flines
