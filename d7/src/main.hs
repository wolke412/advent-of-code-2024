module Main where

import System.IO (readFile)
import Data.List (words, sort)
import Text.Read (read)
import Control.Monad (replicateM)
import Debug.Trace (trace)

--  // 

file1 :: FilePath
file1 = "../assets/input_1.txt"

file2 :: FilePath
file2 = "../assets/input_2.txt"

input :: FilePath -> IO [String]
input p = readFile p >>= return . lines

perms :: Int -> [[Char]]
perms x = replicateM x operators

-- part 1 or 2 is defined here
operators :: [Char]
operators = ['+', '*', '|']
-- operators = ['+', '*']

doOperation :: Char -> (Int, Int) -> Int
doOperation op (x,y)
    | op == '*' = x * y
    | op == '+' = x + y
    | op == '|' = read( show y ++ show x )
    | otherwise = x

isValid :: Int -> [Int] -> [Char] -> Bool
isValid total expr operators =

    let res = foldl (\acc (v, op) -> doOperation op (v, acc) ) 0 iter 
        in trace ( show (total, res) )

    res == total
    where
        iter = zip expr (' ' : operators)

validateExpr :: (Int, [Int]) -> Int
validateExpr (total, expr)

    | any (isValid total expr) ( perms sz ) = total
    | otherwise = 0

    where
        l = length expr
        sz = l - 1


validate :: [(Int, [Int])] -> Int
validate  = foldr (\l acc -> validateExpr l + acc ) 0


main :: IO ()
main = do
    flines <- input file1

    let ch_exprs = [ (r, drop 2 rest) | line <- flines, let (r, rest) = break (== ':') line ]
    let exprs = [ ( read  r :: Int, [ read x :: Int | x <- words rest ] ) | (r, rest) <- ch_exprs ]

    let valid = validate exprs
    print valid

