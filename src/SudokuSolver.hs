module Sudoku where

import Data.Maybe (fromMaybe)
import Debug.Trace (trace)
import InputSizeReader (sizeBoard)
import Prelude

getXY :: Show a => Maybe [[a]] -> Int -> Int -> a
getXY Nothing _ _ = error "getXY: Nothing"
getXY (Just grid) x y =  grid !! x !! y

setXY :: Maybe [[a]] -> Int -> Int -> a -> Maybe [[a]]
setXY Nothing _ _ _ = error "setXY: Nothing"
setXY (Just grid) r c val = Just (take r grid ++ [take c (grid !! r) ++ [val] ++ drop (c + 1) (grid !! r)] ++ drop (r + 1) grid)

getSudokuGrid :: Int -> Maybe [[Int]]
getSudokuGrid sizeBoard = Just (replicate sizeBoard (replicate sizeBoard 0))

getRow :: Maybe [[Int]] -> Int -> Int -> [Int]
getRow Nothing _ _ = []
getRow (Just grid) x y = grid !! x

getCol :: Maybe [[Int]] -> Int -> Int -> [Int]
getCol Nothing _ _ = []
getCol (Just grid) x y = map (!! y) grid

getSquare :: Show a => Maybe [[a]] -> Int -> Int -> Int -> [a]
getSquare Nothing _ _ _ = []
getSquare (Just grid) x y sizeBoard =
  [getXY (Just grid) i j | i <- [startRow..startRow + sqrt sizeBoard - 1], j <- [startColumn..startColumn + sqrt sizeBoard - 1]]
    where
      startRow = x - x `mod` sqrt sizeBoard
      startColumn = y - y `mod` sqrt sizeBoard

compareBigger :: Maybe [[Int]] -> Int -> Int -> Int -> Int -> Bool
compareBigger Nothing _ _ _ _ = False
compareBigger (Just grid) x y value 0 = value > getXY (Just grid) (x-1) y || getXY (Just grid) (x-1) y == 0
compareBigger (Just grid) x y value 1 = value > getXY (Just grid) x (y+1) || getXY (Just grid) x (y+1) == 0
compareBigger (Just grid) x y value 2 = value > getXY (Just grid) (x+1) y || getXY (Just grid) (x+1) y == 0
compareBigger (Just grid) x y value 3 = value > getXY (Just grid) x (y-1) || getXY (Just grid) x (y-1) == 0
compareBigger (Just grid) x y value n
  | n < 0 || n > 3 = error "compareBigger: n is not in range 0..3"
  | otherwise = compareBigger (Just grid) x y value n

compareSmaller :: Maybe [[Int]] -> Int -> Int -> Int -> Int -> Bool
compareSmaller Nothing _ _ _ _ = False
compareSmaller (Just grid) x y value 0 = value < getXY (Just grid) (x-1) y || getXY (Just grid) (x-1) y == 0
compareSmaller (Just grid) x y value 1 = value < getXY (Just grid) x (y+1) || getXY (Just grid) x (y+1) == 0
compareSmaller (Just grid) x y value 2 = value < getXY (Just grid) (x+1) y || getXY (Just grid) (x+1) y == 0
compareSmaller (Just grid) x y value 3 = value < getXY (Just grid) x (y-1) || getXY (Just grid) x (y-1) == 0
compareSmaller (Just grid) x y value n
  | n < 0 || n > 3 = error "compareSmaller: n is not in range 0..3"
  | otherwise = compareSmaller (Just grid) x y value n

executeComparison :: Maybe [[Int]] -> Char -> Int -> Int -> Int -> Int -> Bool
executeComparison sudokuGrid comparator x y value operatorType
  | comparator == '.' =  True
  | comparator == '>' =  compareBigger sudokuGrid x y value operatorType
  | comparator == '<' =  compareSmaller sudokuGrid x y value operatorType
  | otherwise = error "executeComparison: Invalid comparator"

getCompare :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> [Int]
getCompare sudokuGrid comparatorsGrid x y = [a | a <- [1..sizeBoard], canFitComparators a]
  where
    comparators = getXY (Just comparatorsGrid) x y
    canFitComparators a = all (==True) [executeComparison sudokuGrid (comparators !! index) x y a index | index <- [0..3]]

getPossibleOptions :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> [Int]
getPossibleOptions sudokuGrid sudokuGridChars x y = [a | a <- [1..sizeBoard], notInRow a, notInCol a, notInSquare a, inCompareOptions a]
    where
        notInRow a = a `notElem` getRow sudokuGrid x y
        notInCol a = a `notElem` getCol sudokuGrid x y
        notInSquare a = a `notElem` getSquare sudokuGrid x y sizeBoard
        inCompareOptions a = a `elem` getCompare sudokuGrid sudokuGridChars x y

getValueInList :: [a] -> Int -> a
getValueInList [] _ = error "getValueInList: index too large"
getValueInList (x:xs) i
  | i == 0 = x
  | otherwise = getValueInList xs (i - 1)

getListLength :: [a] -> Int
getListLength [] = 0
getListLength (_:xs) = 1 + getListLength xs


solveSudoku :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> Maybe [[Int]]
solveSudoku sudokuGrid comparatorsGrid row column = do
  -- Verifica se chegou na ultima célula, retorna o tabuleiro
  if row == (sizeBoard - 1) && column == sizeBoard then trace "Found the solution: " sudokuGrid
  -- Verifica se chegou no final de uma linha, se sim passa para a próxima
  else if column == sizeBoard then solveSudoku sudokuGrid comparatorsGrid (row + 1) 0
  -- Verifica se o valor da célula atual já foi definido, se foi passa para a próxima célula
  else if getXY sudokuGrid row column > 0 then trace "Value already defined" solveSudoku sudokuGrid comparatorsGrid row (column + 1)
  else do
      -- Pega os possíveis números para a posição atual
      possibles <- Just (getPossibleOptions sudokuGrid comparatorsGrid row column)
      -- Após validar a posição e adquirir os possíveis números chama o for
      solveSudokuWithValues sudokuGrid comparatorsGrid row column possibles 0

-- A partir de uma lista de possíveis números para uma posição específica testa cada um deles até terminar a lista ou algum funcionar
solveSudokuWithValues :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> [Int] -> Int -> Maybe [[Int]]
solveSudokuWithValues sudokuGrid comparatorsGrid row column possibles index = do
  -- Verifica se o index ultrapassou o tamanho da lista, nesse caso não há solução
  if index >= getListLength possibles then Nothing
  else do
    -- Seta a grid com o valor encontrado na lista de possibilidades no index recebido
    sudokuGrid <- setXY sudokuGrid row column (getValueInList possibles index)
    -- Continua o fluxo para a próxima célula e verifica o retorno
    case solveSudoku (Just sudokuGrid) comparatorsGrid row (column + 1) of
      -- Caso seja Nothing, não houve solução irá resetar o valor e tentar o próximo da lista de possibilidades
      Nothing -> do
        setXY (Just sudokuGrid) row column 0
        solveSudokuWithValues (Just sudokuGrid) comparatorsGrid row column possibles (index + 1)
      -- Caso seja um tabuleiro é pq houve solução, então retorna a solução
      Just n -> Just n
