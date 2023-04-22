module OutputGenerator (printMatrix) where

printLine :: [Int] -> IO ()
printLine [] = putStrLn ""
printLine (x:xs) = do
    putStr (show x)
    putStr " "
    printLine xs

printMatrix :: Maybe [[Int]] -> IO()
printMatrix matrix = do
    case matrix of
        Nothing -> putStrLn "No solution"
        Just (x:xs) -> do
            case xs of
                [] -> printLine x
                _ -> do
                    printLine x
                    printMatrix (Just xs)
