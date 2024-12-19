module Main where

import Data.List (sort, words, findIndex, elemIndex, find, nub)
import System.IO (readFile)
import Text.Read (read)

--  //

file1 :: FilePath
file1 = "../assets/input_1.txt"

file2 :: FilePath
file2 = "../assets/input_2.txt"

input :: FilePath -> IO [String]
input p = readFile p >>= return . lines

findInitialPos :: [Char] -> Int
findInitialPos row =
    case p of
        Nothing -> -1
        Just n -> n
    where
        p = elemIndex '^' row

-- offsets
up :: (Int, Int)
up = (0, -1)
right :: (Int, Int)
right = (1, 0)
down :: (Int, Int)
down  = (0, 1)
left :: (Int, Int)
left = (-1, 0)

rotate :: (Int, Int) -> (Int, Int)
rotate cur 
    | cur == up    = right
    | cur == right = down
    | cur == down  = left 
    | cur == left  = up 

vec2Sub :: (Int, Int) -> (Int, Int) -> (Int, Int)
vec2Sub (x1, y1) (x2, y2) = (x1 - x2, y1 - y2)

vec2Add :: (Int, Int) -> (Int, Int) -> (Int, Int)
vec2Add (x1, y1) (x2, y2) = (x1 + x2, y1 + y2)


joinTransform :: (Int, Int) -> (Int, Int) -> (Int, Int, (Int, Int))
joinTransform (x, y) dir = (x, y, dir)

calcGuardPath :: (Int, Int, (Int, Int)) -> [String] -> [Int] -> [Int]
calcGuardPath guard area visited
    | not is_barrier && isBound (x, y) dim = nvisited
    | otherwise          = calcGuardPath ( joinTransform newpos newdir ) area nvisited
    where 
        (x, y, dir) = guard

        width  = length $ head area
        height  = length area 

        dim = ( width, height )

        curchar = ( area !! y ) !! x 
        oldpos = vec2Sub (x, y) dir
        is_barrier = isBarrier curchar 

        newdir = if is_barrier then rotate dir else dir
        newpos 
            | is_barrier = vec2Add oldpos $ rotate dir
            | otherwise         = vec2Add (x,y) dir
        nvisited
            | is_barrier = visited
            | otherwise  = visited ++ [ y * width + x ]


isBarrier :: Char -> Bool
isBarrier = (== '#')

isBound :: (Int, Int) -> (Int, Int) -> Bool
isBound (x, y) (w, h) 
    | x == 0     = True
    | y == 0     = True
    | x == w - 1 = True
    | y == h - 1 = True
    | otherwise  = False 

main :: IO ()
main = do

  grid <- input file1

  let startingPos = map findInitialPos grid  

  -- "inverted" -> not akshually inverted
  -- just the way I GET THE Info
  let Just(y, x) = find (\(_, v) -> v /= -1) (zip [0..] startingPos)

  let guard = (x, y, up) 
  let path = nub $ calcGuardPath guard grid [] 

  print path 
  print ( length path)
