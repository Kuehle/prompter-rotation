{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Text(pack, unpack, replace)
import System.Environment
import Data.Bifunctor
import System.Directory

popEnqueue (x:xs) = (x, xs ++ [x])
popEnqueue [] = ("", [""])

readLines :: FilePath -> IO [String]
readLines fp = lines <$> readFile fp        
        
writeFileLines :: [String] -> FilePath -> IO ()
writeFileLines strings fp = writeFile fp (unlines strings)

main :: IO ()
main = do
    [questionsPath, templatePath, outputPath] <- getArgs
    questions <- readLines questionsPath
    let (question, newQuestions) = popEnqueue questions
    writeFileLines newQuestions ('_' : questionsPath )
    removeFile questionsPath
    renameFile ('_' : questionsPath) questionsPath
    template <- readFile templatePath
    let output = replace "%%%" (pack question) (pack template)
    writeFile outputPath (unpack output)
    putStrLn "Done"
