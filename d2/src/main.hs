
module Main where

import System.IO (readFile)
import Data.List 
import Text.Read (read, readMaybe)

import qualified Part2 as P2
import Data.ByteString (count)

--  // 

file1 :: FilePath
file1 = "../assets/input_1.txt"

file2 :: FilePath
file2 = "../assets/input_2.txt"

readInputLines :: FilePath -> IO [String]
readInputLines path = do
    content <- readFile path
    return (lines content) 

checkList0 :: [Int] -> Bool
checkList0 (h:s:rest)
    | checkDiffs d1 d2 = checkList (s:rest, d2)
    | otherwise = False
    where 
        d2 = h - s
        d1 = if d2 > 0 then 1 else -1 

  
checkList :: ([Int], Int) -> Bool
checkList ( [h], d1 ) = True
checkList ( h:s:rest, d1 ) 

    | checkDiffs d1 d2 = checkList (s:rest, d2)
    | otherwise        = False
    where
        d2 = h - s


checkDiffs :: Int -> Int -> Bool
checkDiffs d1 d2 
    | abs d2 > 3  = False
    | d1 * d2 > 0 = True
    | otherwise   = False


main :: IO ()
main = do

    flines <- readInputLines file1

    let w = [words x | x <- flines]
    let r = [ 
                [ n | Just n <- map (readMaybe :: String -> Maybe Int) line ] 
                | line <- w 
            ]  


    let ifs = map checkList0 r 

    print (countTrues ifs)
    




    let ifs = map P2.checkListStart ( map (\sub -> (sub, 0)) r)
    -- let t = [ ((r !! 143), 0) ]
    -- let ifs = map P2.checkListStart r
    -- print t
    

    print (countTrues ifs)
    -- print (trueIndexes ifs)


    where 
        countTrues :: [Bool] -> Int
        countTrues xs = length (filter (== True) xs)

        trueIndexes :: [Bool] -> [Int]
        trueIndexes list = [i | (i, val) <- zip [0..] list, val] 