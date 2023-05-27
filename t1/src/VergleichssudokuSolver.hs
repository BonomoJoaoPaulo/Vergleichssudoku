module VergleichssudokuSolver where

import Data.Maybe (fromMaybe)
import Debug.Trace (trace)
import SizeConfig(sizeBoard, sizeRowRegion, sizeColumnRegion)

-- Retorna o valor de uma matriz em uma determinada posição.
getXY :: Show a => Maybe [[a]] -> Int -> Int -> a
getXY Nothing _ _ = error "getXY: Nothing" -- Caso base: matriz vazia.
getXY (Just grid) x y =  grid !! x !! y -- Caso recursivo: retorna o valor da posição (x, y) da matriz.

-- Altera o valor de uma matriz em uma determinada posição (x, y).
setXY :: Maybe [[a]] -> Int -> Int -> a -> Maybe [[a]]
setXY Nothing _ _ _ = error "setXY: Nothing" -- Caso base: matriz vazia.
setXY (Just grid) r c val = Just (take r grid ++ [take c (grid !! r) ++ [val] ++ drop (c + 1) (grid !! r)] ++ drop (r + 1) grid)

-- Retorna a matriz inicial do tabuleiro, com o tamanho configurado pelo usuário em SizeConfig.hs.
getVergleichssudokuGrid :: Int -> Maybe [[Int]]
getVergleichssudokuGrid sizeBoard = Just (replicate sizeBoard (replicate sizeBoard 0))

-- Retorna a linha (x) na posição (x, y) do tabuleiro.
getRow :: Maybe [[Int]] -> Int -> Int -> [Int]
getRow Nothing _ _ = []
getRow (Just grid) x y = grid !! x

-- Retorna a coluna (x) na posição (x, y) do tabuleiro.
getCol :: Maybe [[Int]] -> Int -> Int -> [Int]
getCol Nothing _ _ = []
getCol (Just grid) x y = map (!! y) grid

-- A função getRegion recebe uma matriz de elementos, um valor x, um valor y e o tamanho do tabuleiro como entrada.
-- Ela retorna a região correspondente à posição (x, y) na matriz.
-- O tamanho da região é calculado com base nas dimensões fornecidas pelo usuário em SizeConfig.hs.
getRegion :: Show a => Maybe [[a]] -> Int -> Int -> Int -> [a]
getRegion Nothing _ _ _ = [] -- Caso base: matriz vazia.
getRegion (Just grid) x y sizeBoard =
  [getXY (Just grid) i j | i <- [startRow..startRow + sizeRowRegion - 1], j <- [startColumn..startColumn + sizeColumnRegion - 1]]
    where
      startRow = x - x `mod` sizeRowRegion -- Linha inicial daquela região.
      startColumn = y - y `mod` sizeColumnRegion -- Coluna inicial daquela região.

-- Função responsável pelas comparações de MAIOR QUE.
compareBigger :: Maybe [[Int]] -> Int -> Int -> Int -> Int -> Bool
compareBigger Nothing _ _ _ _ = False
compareBigger (Just grid) x y value 0 = value > getXY (Just grid) (x-1) y || getXY (Just grid) (x-1) y == 0
compareBigger (Just grid) x y value 1 = value > getXY (Just grid) x (y+1) || getXY (Just grid) x (y+1) == 0
compareBigger (Just grid) x y value 2 = value > getXY (Just grid) (x+1) y || getXY (Just grid) (x+1) y == 0
compareBigger (Just grid) x y value 3 = value > getXY (Just grid) x (y-1) || getXY (Just grid) x (y-1) == 0
compareBigger (Just grid) x y value n
  | n < 0 || n > 3 = error "compareBigger: n is not in range 0..3"
  | otherwise = compareBigger (Just grid) x y value n

-- Função responsável pelas comparações de MENOR QUE.
compareSmaller :: Maybe [[Int]] -> Int -> Int -> Int -> Int -> Bool
compareSmaller Nothing _ _ _ _ = False
compareSmaller (Just grid) x y value 0 = value < getXY (Just grid) (x-1) y || getXY (Just grid) (x-1) y == 0
compareSmaller (Just grid) x y value 1 = value < getXY (Just grid) x (y+1) || getXY (Just grid) x (y+1) == 0
compareSmaller (Just grid) x y value 2 = value < getXY (Just grid) (x+1) y || getXY (Just grid) (x+1) y == 0
compareSmaller (Just grid) x y value 3 = value < getXY (Just grid) x (y-1) || getXY (Just grid) x (y-1) == 0
compareSmaller (Just grid) x y value n
  | n < 0 || n > 3 = error "compareSmaller: n is not in range 0..3"
  | otherwise = compareSmaller (Just grid) x y value n

-- Função responsável por executar as comparações.
executeComparison :: Maybe [[Int]] -> Char -> Int -> Int -> Int -> Int -> Bool
executeComparison vergleichssudokuGrid comparator x y value operatorType
  | comparator == '.' =  True
  | comparator == '>' =  compareBigger vergleichssudokuGrid x y value operatorType
  | comparator == '<' =  compareSmaller vergleichssudokuGrid x y value operatorType
  | otherwise = error "executeComparison: Invalid comparator"

-- Pega as comparações de uma determinada posição.
getCompare :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> [Int]
getCompare vergleichssudokuGrid comparatorsGrid x y = [a | a <- [1..sizeBoard], canFitComparators a]
  where
    comparators = getXY (Just comparatorsGrid) x y
    canFitComparators a = all (==True) [executeComparison vergleichssudokuGrid (comparators !! index) x y a index | index <- [0..3]]

-- Retorna uma lista com as opções possíveis para uma determinada posição.
getPossibleOptions :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> [Int]
getPossibleOptions vergleichssudokuGrid vergleichssudokuGridChars x y = [a | a <- [1..sizeBoard], notInRow a, notInCol a, notInSquare a, inCompareOptions a]
    where
        notInRow a = a `notElem` getRow vergleichssudokuGrid x y
        notInCol a = a `notElem` getCol vergleichssudokuGrid x y
        notInSquare a = a `notElem` getRegion vergleichssudokuGrid x y sizeBoard
        inCompareOptions a = a `elem` getCompare vergleichssudokuGrid vergleichssudokuGridChars x y

 -- Retorna o valor de uma lista em um determinado índice. 
getValueInList :: [a] -> Int -> a
getValueInList [] _ = error "getValueInList: index too large" -- Caso base: lista vazia.
-- Caso recursivo: retorna o valor da cabeça da lista caso o índice seja 0, caso contrário, chama a função novamente com a cauda da lista e o índice decrementado.
getValueInList (x:xs) i 
  | i == 0 = x -- Caso base: índice 0.
  | otherwise = getValueInList xs (i - 1) -- Caso recursivo: chama a função novamente com a cauda da lista e o índice decrementado.

-- Retorna o tamanho de uma lista
getListLength :: [a] -> Int
getListLength [] = 0 -- Caso base: lista vazia.
getListLength (_:xs) = 1 + getListLength xs -- Caso recursivo: soma 1 ao tamanho da cauda da lista.

-- Função responsável pela solução do tabuleiro.
-- Recebe o tabuleiro, o tabuleiro de comparações, a linha atual e a coluna atual.
solveVergleichssudoku :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> Maybe [[Int]]
solveVergleichssudoku vergleichssudokuGrid comparatorsGrid row column = do
  -- Retorna o tabuleiro caso tenha chegado na última célula.
  if row == (sizeBoard - 1) && column == sizeBoard then trace "Found the solution: " vergleichssudokuGrid
  -- Verifica se chegou ao fim de uma linha, caso tenha chegado, salta para a próxima.
  else if column == sizeBoard then solveVergleichssudoku vergleichssudokuGrid comparatorsGrid (row + 1) 0
  -- Verifica se o valor da célula atual já foi definido, caso tenha sido, passa para a próxima célula.
  else if getXY vergleichssudokuGrid row column > 0 then trace "Value already defined" solveVergleichssudoku vergleichssudokuGrid comparatorsGrid row (column + 1)
  else do
      -- Checa os valores possíveis para a célula atual.
      possibles <- Just (getPossibleOptions vergleichssudokuGrid comparatorsGrid row column)
      -- Após validar a posição e adquirir os possíveis números chama a função recursiva que testa cada um deles.
      solveVergleichssudokuWithValues vergleichssudokuGrid comparatorsGrid row column possibles 0

-- A partir de uma lista de possíveis números para uma posição específica testa cada um deles até terminar a lista ou algum funcionar
solveVergleichssudokuWithValues :: Maybe [[Int]] -> [[[Char]]] -> Int -> Int -> [Int] -> Int -> Maybe [[Int]]
-- Caso a lista de possibilidades esteja vazia, não há solução para o tabuleiro de entrada.
solveVergleichssudokuWithValues vergleichssudokuGrid comparatorsGrid row column possibles index = do
  -- Verifica se o index ultrapassou o tamanho da lista, nesse caso não há solução possível para o tabuleiro de entrada.
  if index >= getListLength possibles then Nothing
  else do
    -- "Seta" a grid com o valor encontrado na lista de possibilidades no index recebido.
    vergleichssudokuGrid <- setXY vergleichssudokuGrid row column (getValueInList possibles index)
    -- Continua o "flow" para a célula seguinte e verifica o retorno.
    case solveVergleichssudoku (Just vergleichssudokuGrid) comparatorsGrid row (column + 1) of
      -- Caso seja Nothing, não houve uma solução.
      Nothing -> do
        -- Reseta o valor da célula atual.
        setXY (Just vergleichssudokuGrid) row column 0
        -- Chamada recursiva para testar o próximo valor da lista de possibilidades.
        solveVergleichssudokuWithValues (Just vergleichssudokuGrid) comparatorsGrid row column possibles (index + 1)
      -- Retorna a solução.
      Just n -> Just n
