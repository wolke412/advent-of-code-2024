#!/bin/bash

# Check if the script received the first parameter (folder name)
if [ -z "$1" ]; then
    echo "Usage: $0 <folder-name>"
    exit 1
fi

# Get the folder name from the first parameter
FOLDER_NAME="$1"

# Create the folder structure
mkdir -p "$FOLDER_NAME/src"
mkdir -p "$FOLDER_NAME/assets"

# Create the main.hs file with the specified content
cat << 'EOF' > "$FOLDER_NAME/src/main.hs"
module Main where

import System.IO (readFile)
import Data.List (words, sort)
import Text.Read (read)

--  // 

file1 :: FilePath
file1 = "../static/input_1.txt"

file2 :: FilePath
file2 = "../static/input_2.txt"

readInputLines :: FilePath -> IO [String]
readInputLines path = do
    content <- readFile path
    return (lines content) 

main :: IO ()
main = do
    putStrLn "Reading input file 1:"
    flines <- readInputLines file1
    
    print flines
EOF

# Create the input files
touch "$FOLDER_NAME/assets/input_1.txt"
touch "$FOLDER_NAME/assets/input_2.txt"

echo "Project structure created successfully in $FOLDER_NAME."

