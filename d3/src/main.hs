module Main where

import System.IO (readFile)
import Data.List (words, sort)
import Text.Read (read)

import Text.Parsec
import Text.Parsec.Char
import Data.Void

type Parser = Parsec Void String

-- Example parser: Match "long" followed by a space and another word
patternParser :: Parser String
patternParser = do
  _ <- string "long "
  word <- some letterChar
  word

file1 :: FilePath
file1 = "../assets/input_1.txt"

file2 :: FilePath
file2 = "../assets/input_2.txt"

readInputLines :: FilePath -> IO [String]
readInputLines path = do
    content <- readFile path
    return (lines content) 

main :: IO ()
main = do
    content <- readFile file1 


    print flines
