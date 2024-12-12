module Part2 ( checkListStart ) where

import Debug.Trace ( trace )
import Data.ByteString (count)

diffs :: [Int] -> [Int]
diffs [_]      = []
diffs (x:y:xs) = (x - y) : diffs (y:xs)

filterWrongs :: [Int] -> [Int] 
filterWrongs = filter isWrong

countWrongs :: [Int] -> Int
countWrongs = length . filterWrongs

isWrong :: Int -> Bool
isWrong x = abs x > 3 || x == 0 

hasWrongs :: [Int] -> Bool
hasWrongs l 
    | countWrongs l > 0                = True
    | countPos l > 0 && countNeg l > 0 = True
    | otherwise                        = False

countNeg :: [Int] -> Int 
countNeg l = length ( filter (<0) l)
    
countPos :: [Int] -> Int 
countPos l = length ( filter (>0) l)

dropIndex :: [Int] -> Int -> [Int]
dropIndex arr i = 
    case r of 
        [] -> l
        (_:x) -> l ++ x
  where 
    ( l, r ) = splitAt i arr

checkDropping :: [Int] -> Bool
checkDropping l = check l 0 (length l)

check :: [Int] -> Int -> Int -> Bool    
check l i max
    | i == max           = False
    | not ( hasWrongs d ) = True
    | otherwise          = check l (i + 1) max
    where 
        f = dropIndex l i
        d = diffs f

checkListStart :: ([Int], Int) -> Bool
checkListStart (list, err)
    -- trace (": " ++ show ( checkDropping list ) )
    | not (hasWrongs d) = True
    | otherwise          = checkDropping list 

    where 
        d = diffs list


