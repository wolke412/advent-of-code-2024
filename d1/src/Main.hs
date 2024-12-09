
module Main where

import System.IO (readFile)
import Data.List (words, sort)
import Text.Read (read)
import qualified Data.Map.Strict as Map
import Data.Map.Strict (Map)


--  // 

file1 :: FilePath
file1 = "../static/input_1.txt"

file2 :: FilePath
file2 = "../static/input_2.txt"

readInputLines :: FilePath -> IO [String]
readInputLines path = do
    content <- readFile path
    
    let n_lines = lines content

    return (lines content) 

split :: [String] -> [( String, String )]
split s = [ ( x, y ) | [x, y] <- map words s ]

parse :: [ ( String, String ) ] -> [(Int, Int)]
parse s = [ ( read l, read r ) | (l, r) <- s ]

diff :: [(Int, Int)] -> [Int]
diff l = [ abs (l - r) | (l, r) <- l ]

summation :: [Int] -> Int
summation = foldr (\acc (cur) -> acc + cur) 0


-- Part 2 functions

-- Since inputs are controled no need for typeguards
createMap :: [Int] -> Map Int Int
createMap = foldl (\acc x -> Map.insertWith (+) x 1 acc) Map.empty


main :: IO ()
main = do
    
    putStrLn "Reading input file 1:"
    flines <- readInputLines file1

    let spl = split flines
    let p = parse spl
    let ( left, right ) = unzip p  
    let z = zip (sort left) (sort right)
    let d = diff z

    -- part 1
    print ( summation d )

    -- for part 2 input still the same;

    let spl = split flines
    let p = parse spl
    let (left, right) = unzip p  

    let m = createMap right

    let scores = [ key * score |   
                        key <- left, 
                        val <- [ Map.lookup key m ], 
                        score <- [ 
                            case val of
                                Just v  -> v
                                Nothing -> 0
                        ] 
                ]

    -- part 2
    print ( summation scores )



