module Main where

import System.IO (readFile)
import Data.List (words, sort)
import Text.Read (read)
import GHC.Base (SPEC(SPEC))
import Debug.Trace (trace)
import Text.Printf (IsChar(toChar))
import Text.ParserCombinators.ReadP (count)

--  // 

fileTest :: FilePath
fileTest = "../assets/input_test.txt"

file1 :: FilePath
file1 = "../assets/input_1.txt"

file2 :: FilePath
file2 = "../assets/input_2.txt"

input :: FilePath -> IO [String]
input p = readFile p >>= return . lines



-- Comment defines part 1 or 2
xmas :: String
-- xmas = "XMAS"
xmas = "MAS"

samx :: String
samx = reverse xmas

substring :: Int -> Int -> String -> String
substring n m = take (m - n + 1) . drop n

slice :: Int -> Int -> [t] -> [t]
slice n m = take (m - n + 1) . drop n
-- part1 :: [[Char]] -> Int
-- part1 lns =

checkInLine :: [Char] -> Int
checkInLine ln =
    checkLineAt ln 0 l 0
    where
        l = length ln


seek :: [Char] -> Int -> [Char] -> Int -> Int
seek list idx exp eidx
    | eidx == 4         = 0 -- FOUND
    | found == expected = seek list (idx+1) exp (eidx+1)
    | otherwise         = eidx
    where
        found    = list !! idx
        expected = exp !! eidx

seekD :: [[Char]] -> Int -> [Char] -> Int -> Int -> Int
seekD lists idx exp eidx dir
    | eidx == ws        = trace (show dir ++" "++ exp) 0 -- FOUND
    | found == expected = seekD lists (idx+1) exp (eidx+1) dir
    | otherwise         = eidx
    where
        ws   = length exp
        list = lists !! eidx   -- 1 or -1 for direction 
        xoffset
            | dir < 0  = eidx*2*dir
            | dir == 0 = -eidx
            | dir > 0  = 0
        found    = list  !! (idx + xoffset)
        expected = exp   !! eidx


checkLineDiagonalsAt :: [[Char]] -> Int -> Int -> ([Int], [Int], [Int]) -> ([Int], [Int], [Int])
checkLineDiagonalsAt lns at max actual
    | max - at == 0   = actual
    | seeked /= -3    = checkLineDiagonalsAt lns (at + 1) max ( 
                            l ++ [nl | nl /= -1],
                            v ++ [nv | nv /= -1],
                            r ++ [nr | nr /= -1]
                        )

    | otherwise       = checkLineDiagonalsAt lns (at + 1) max actual
    where

        ( l,v,r ) = actual
        ln = head lns
        ch = ln !! at
        ws = length xmas

        st1 = head xmas 
        st2 = head samx 

        seekDir dir
            | dir == -1 && at < (ws - 1) = -1
            | dir == 1  && max - at < ws = -1

            | ch == st1 = seekD lns at xmas 0 dir
            | ch == st2 = seekD lns at samx 0 dir

            | otherwise = -1

        seekedL = seekDir (-1)
        seekedV = seekDir 0
        seekedR = seekDir 1

        seeked = seekedL + seekedR + seekedV
        new = length $ filter (==0) [seekedL, seekedR, seekedV]
    
        -- part 2 stuff
        (nl,nv,nr) = (
                if seekedL == 0 then at else -1,
                if seekedV == 0 then at else -1,
                if seekedR == 0 then at else -1
            )



checkLineAt :: [Char] -> Int -> Int -> Int -> Int
checkLineAt ln at max c
    | max - at < 4 = c
    | seeked /= -1 = checkLineAt ln (at + jump) max newC
    | otherwise = checkLineAt ln (at+1) max c
    where
        ch = ln !! at

        seeked = case ch of
            'X' -> seek ln at xmas 0
            'S' -> seek ln at samx 0
            _ -> -1 

        newC = if seeked == 0 then c + 1 else c
        jump = if seeked == 0 then 3 else seeked

-- part 2
-- yea yea O(m*n) fuck you 
countValidsXs :: ([Int], [Int], [Int]) -> Int
countValidsXs (l, _ , []) = 0
countValidsXs (l, _ , r) = foldr check 0 r
    where 
        check x acc 
            | (x + 2) `elem` l = acc + 1 
            | otherwise = acc


main :: IO ()
main = do
    -- flines <- input fileTest
    flines <- input file1

    let inp = flines 
    let l   = length inp
    let lw  = length xmas
    let diagRange = [0..(l-lw)]

    -- Sends X(3 or 4) rows each time
    let m = map (\i -> slice i (i + 3) inp) diagRange

    -- Part 1
    let atLine = map checkInLine inp 
    -- let atDiag = map (\l -> checkLineDiagonalsAt l 0 (length $ head inp ) (0)) m 
    -- print ( sum atLine + sum atDiag )

    -- Part 2
    let atDiag = map (\l -> checkLineDiagonalsAt l 0 (length $ head inp ) ([],[],[])) m 
    let x = map countValidsXs atDiag

    print ( sum x )
