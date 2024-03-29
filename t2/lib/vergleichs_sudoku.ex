defmodule VergleichsSudoku do
  @moduledoc """
  Solucionador para o VergleichsSudoku.
  """

  @doc """
  Retorna o valor de uma matriz em uma determinada posição.
  Caso base: matriz vazia.
  """
  def getXY(nil, _, _) do
    raise "getXY: Nothing"
  end

  @doc """
  Retorna o valor de uma matriz em uma determinada posição.
  Caso recursivo: retorna o valor da posição (x, y) da matriz.
  """
  def getXY(grid, x, y) do
    Enum.at(Enum.at(grid, x), y)
  end

  @doc """
  Altera o valor de uma matriz em uma determinada posição (x, y).
  Caso base: matriz vazia.
  """
  def setXY(nil, _, _, _, _) do
    raise "setXY: Nothing"
  end

  @doc """
  Altera o valor de uma matriz em uma determinada posição (x, y).
  """
  def setXY(grid, r, c, val) do
    new_grid = List.replace_at(grid, r, List.replace_at(Enum.at(grid, r), c, val))
    new_grid
  end

  @doc """
  Retorna a matriz inicial do tabuleiro, com o tamanho configurado pelo usuário em SizeConfig.hs.
  """
  @spec getVergleichsSudokuGrid(non_neg_integer) :: nil | [[integer]]
  def getVergleichsSudokuGrid(sizeBoard) when sizeBoard > 0 do
    grid = List.duplicate(List.duplicate(0, sizeBoard), sizeBoard)
    grid
  end

  def getVergleichsSudokuGrid(_sizeBoard) do
    nil
  end

  @doc """
  Retorna a linha (x) na posição (x, y) do tabuleiro.
  Exceção.
  """
  @spec getRow(nil | [[integer]], non_neg_integer, non_neg_integer) :: [integer]
  def getRow(nil, _, _) do
    []
  end

  @doc """
  Retorna a linha (x) na posição (x, y) do tabuleiro.
  """
  @spec getRow([[integer]], non_neg_integer, non_neg_integer) :: [integer]
  def getRow(grid, x, _) do
    Enum.at(grid, x)
  end

  @doc """
  Retorna a coluna (x) na posição (x, y) do tabuleiro.
  Exceção.
  """
  @spec getCol(nil | [[integer]], non_neg_integer, non_neg_integer) :: [integer]
  def getCol(nil, _, _) do
    []
  end

  @doc """
  Retorna a coluna (x) na posição (x, y) do tabuleiro.
  """
  @spec getCol([[integer]], non_neg_integer, non_neg_integer) :: [integer]
  def getCol(grid, _, y) do
    Enum.map(grid, &Enum.at(&1, y))
  end

  @doc """
  A função getRegion recebe uma matriz de elementos, um valor x, um valor y e o tamanho do tabuleiro como entrada.
  Ela retorna a região correspondente à posição (x, y) na matriz.
  O tamanho da região é calculado com base nas dimensões fornecidas pelo usuário em SizeConfig.hs.
  """
  def getRegion(grid, x, y, _sizeBoard) do
    # Linha inicial daquela região.
    startRow = x - rem(x, SizeConfig.sizeRowRegion())
    # Coluna inicial daquela região.
    startColumn = y - rem(y, SizeConfig.sizeColumnRegion())

    for i <- startRow..(startRow + SizeConfig.sizeRowRegion() - 1),
        j <- startColumn..(startColumn + SizeConfig.sizeColumnRegion() - 1),
        do: getXY(grid, i, j)
  end

  #@doc """
  #A função getRegion recebe uma matriz de elementos, um valor x, um valor y e o tamanho do tabuleiro como entrada.
  #Ela retorna a região correspondente à posição (x, y) na matriz.
  #Caso base: matriz vazia.
  #"""
  #def getRegion(nil, _, _, _) do
  #  []
  #end

  @doc """
  Função responsável pelas comparações de MAIOR QUE.
  """
  @spec compareBigger(
          nil | [[integer]],
          non_neg_integer,
          non_neg_integer,
          integer,
          non_neg_integer
        ) :: boolean
  def compareBigger(nil, _, _, _, _) do
    false
  end

  @spec compareBigger([[integer]], non_neg_integer, non_neg_integer, integer, 0..3) ::
          boolean
  def compareBigger(grid, x, y, value, 0) do
    value > getXY(grid, x - 1, y) || getXY(grid, x - 1, y) == 0
  end

  @spec compareBigger([[integer]], non_neg_integer, non_neg_integer, integer, 0..3) ::
          boolean
  def compareBigger(grid, x, y, value, 1) do
    value > getXY(grid, x, y + 1) || getXY(grid, x, y + 1) == 0
  end

  @spec compareBigger([[integer]], non_neg_integer, non_neg_integer, integer, 0..3) ::
          boolean
  def compareBigger(grid, x, y, value, 2) do
    value > getXY(grid, x + 1, y) || getXY(grid, x + 1, y) == 0
  end

  @spec compareBigger([[integer]], non_neg_integer, non_neg_integer, integer, 0..3) ::
          boolean
  def compareBigger(grid, x, y, value, 3) do
    value > getXY(grid, x, y - 1) || getXY(grid, x, y - 1) == 0
  end

  @spec compareBigger([[integer]], non_neg_integer, non_neg_integer, integer, integer) ::
          boolean
  def compareBigger(_grid, _x, _y, _value, n) when n < 0 or n > 3 do
    raise ArgumentError, "compareBigger: n is not in range 0..3"
  end

  @spec compareBigger([[integer]], non_neg_integer, non_neg_integer, integer, integer) ::
          boolean
  def compareBigger(grid, x, y, value, n) do
    compareBigger(grid, x, y, value, n)
  end

  @doc """
  Função responsável pelas comparações de MENOR QUE.
  """
  @spec compareSmaller(
          nil | [[integer]],
          non_neg_integer,
          non_neg_integer,
          integer,
          non_neg_integer
        ) :: boolean
  def compareSmaller(nil, _, _, _, _) do
    false
  end

  @spec compareSmaller([[integer]], non_neg_integer, non_neg_integer, integer, 0..3) ::
          boolean
  def compareSmaller(grid, x, y, value, 0) do
    value < getXY(grid, x - 1, y) || getXY(grid, x - 1, y) == 0
  end

  @spec compareSmaller([[integer]], non_neg_integer, non_neg_integer, integer, 0..3) ::
          boolean
  def compareSmaller(grid, x, y, value, 1) do
    value < getXY(grid, x, y + 1) || getXY(grid, x, y + 1) == 0
  end

  @spec compareSmaller([[integer]], non_neg_integer, non_neg_integer, integer, 0..3) ::
          boolean
  def compareSmaller(grid, x, y, value, 2) do
    value < getXY(grid, x + 1, y) || getXY(grid, x + 1, y) == 0
  end

  @spec compareSmaller([[integer]], non_neg_integer, non_neg_integer, integer, 0..3) ::
          boolean
  def compareSmaller(grid, x, y, value, 3) do
    value < getXY(grid, x, y - 1) || getXY(grid, x, y - 1) == 0
  end

  @spec compareSmaller([[integer]], non_neg_integer, non_neg_integer, integer, integer) ::
          boolean
  def compareSmaller(_grid, _x, _y, _value, n) when n < 0 or n > 3 do
    raise ArgumentError, "compareSmaller: n is not in range 0..3"
  end

  @spec compareSmaller([[integer]], non_neg_integer, non_neg_integer, integer, integer) ::
          boolean
  def compareSmaller(grid, x, y, value, n) do
    compareSmaller(grid, x, y, value, n)
  end

  @doc """
  Função responsável por executar as comparações.
  """
  @spec executeComparison(
          nil | [[integer]],
          char,
          non_neg_integer,
          non_neg_integer,
          integer,
          integer
        ) :: boolean
  def executeComparison(nil, _, _, _, _, _) do
    false
  end

  @spec executeComparison(
          [[integer]],
          char,
          non_neg_integer,
          non_neg_integer,
          integer,
          0..3
        ) :: boolean
  def executeComparison(_vergleichssudokuGrid, ?., _, _, _, _) do
    true
  end

  @spec executeComparison(
          [[integer]],
          char,
          non_neg_integer,
          non_neg_integer,
          integer,
          0..3
        ) :: boolean
  def executeComparison(vergleichssudokuGrid, ?>, x, y, value, operator_type) do
    compareBigger(vergleichssudokuGrid, x, y, value, operator_type)
  end

  @spec executeComparison(
          [[integer]],
          char,
          non_neg_integer,
          non_neg_integer,
          integer,
          0..3
        ) :: boolean
  def executeComparison(vergleichssudokuGrid, ?<, x, y, value, operator_type) do
    compareSmaller(vergleichssudokuGrid, x, y, value, operator_type)
  end

  @spec executeComparison(
          [[integer]],
          char,
          non_neg_integer,
          non_neg_integer,
          integer,
          integer
        ) :: boolean
  def executeComparison(_, _, _, _, _, _) do
    raise ArgumentError, "executeComparison: Invalid comparator"
  end

  @doc """
  Pega as comparações de uma determinada posição.
  """
  def getCompare(vergleichssudokuGrid, comparatorsGrid, x, y) do
    comparators = getXY(comparatorsGrid, x, y)
    canFitComparators = fn a ->
      Enum.all?(
        for index <- 0..3,
            do:
              executeComparison(
                vergleichssudokuGrid,
                comparators |> Enum.at(index),
                x,
                y,
                a,
                index
              )
      )
    end

    size = SizeConfig.sizeBoard()
    for a <- 1..size, canFitComparators.(a), do: a
  end

  @doc """
  Retorna uma lista com as opções possíveis para uma determinada posição.
  """
  def getPossibleOptions(vergleichssudokuGrid, vergleichssudokuGridChars, x, y) do
    Enum.filter(1..SizeConfig.sizeBoard(), fn a ->
      notInRow(a, vergleichssudokuGrid, x, y) and notInCol(a, vergleichssudokuGrid, x, y) and
        notInSquare(a, vergleichssudokuGrid, x, y) and
        inCompareOptions(a, vergleichssudokuGrid, vergleichssudokuGridChars, x, y)
    end)
  end

  @doc """
  Função utilitária que verifica se não está em uma linha
  """
  def notInRow(a, vergleichssudokuGrid, x, y) do
    a not in getRow(vergleichssudokuGrid, x, y)
  end

  @doc """
  Função utilitária que verifica se não está em uma coluna
  """
  def notInCol(a, vergleichssudokuGrid, x, y) do
    a not in getCol(vergleichssudokuGrid, x, y)
  end

  @doc """
  Função utilitária que verifica se não está em um quadrado
  """
  def notInSquare(a, vergleichssudokuGrid, x, y) do
    a not in getRegion(vergleichssudokuGrid, x, y, SizeConfig.sizeBoard())
  end

  @doc """
  Função utilitária que verifica se está nas opções de comparação
  """
  def inCompareOptions(a, vergleichssudokuGrid, vergleichssudokuGridChars, x, y) do
    a in getCompare(vergleichssudokuGrid, vergleichssudokuGridChars, x, y)
  end

  @doc """
  Retorna o valor de uma lista em um determinado índice.
  Caso base: lista vazia.
  """
  @spec getValueInList(list, non_neg_integer) :: any
  def getValueInList([], _) do
    raise "getValueInList: index too large"
  end

  @doc """
  Retorna o valor de uma lista em um determinado índice.
  Caso base: índice 0.
  """
  @spec getValueInList([any], non_neg_integer) :: any
  def getValueInList([x | _], 0) do
    x
  end

  @doc """
  Retorna o valor de uma lista em um determinado índice.
  Caso recursivo: chama a função novamente com a cauda da lista e o índice decrementado.
  """
  @spec getValueInList([any], non_neg_integer) :: any
  def getValueInList([_x | xs], i) when i > 0 do
    getValueInList(xs, i - 1)
  end

  @doc """
  Retorna o tamanho de uma lista
  Caso base: lista vazia.
  """
  @spec getListLength(list) :: non_neg_integer
  def getListLength([]) do
    0
  end

  @doc """
  Retorna o tamanho de uma lista
  Caso recursivo: soma 1 ao tamanho da cauda da lista.
  """
  def getListLength([_ | tail]) do
    1 + getListLength(tail)
  end

  @doc """
  Função responsável pela solução do tabuleiro.
  Recebe o tabuleiro, o tabuleiro de comparações, a linha atual e a coluna atual.
  """
  def solveVergleichsSudoku(vergleichssudokuGrid, comparatorsGrid, row, column) do
    case {row == SizeConfig.sizeBoard() - 1 && column == SizeConfig.sizeBoard(),
          column == SizeConfig.sizeBoard(), getXY(vergleichssudokuGrid, row, column) > 0} do
      # Retorna o tabuleiro caso tenha chegado na última célula.
      {true, _, _} ->
        IO.puts("Found the solution: ")
        vergleichssudokuGrid

      # Verifica se chegou ao fim de uma linha, caso tenha chegado, salta para a próxima.
      {_, true, _} ->
        solveVergleichsSudoku(vergleichssudokuGrid, comparatorsGrid, row + 1, 0)

      # Verifica se o valor da célula atual já foi definido, caso tenha sido, passa para a próxima célula.
      {_, _, true} ->
        IO.puts("Value already defined")
        solveVergleichsSudoku(vergleichssudokuGrid, comparatorsGrid, row, column + 1)

      _ ->
        # Checa os valores possíveis para a célula atual.
        possibles = getPossibleOptions(vergleichssudokuGrid, comparatorsGrid, row, column)

        # Após validar a posição e adquirir os possíveis números chama a função recursiva que testa cada um deles.
        solveVergleichsSudokuWithValues(
          vergleichssudokuGrid,
          comparatorsGrid,
          row,
          column,
          possibles,
          0
        )
    end
  end

  @doc """
  A partir de uma lista de possíveis números para uma posição específica testa cada um deles até terminar a lista ou algum funcionar
  """
  def solveVergleichsSudokuWithValues(
        vergleichssudokuGrid,
        comparatorsGrid,
        row,
        column,
        possibles,
        index
      ) do
    if index >= getListLength(possibles) do
      nil
    else
      updatedGrid = setXY(vergleichssudokuGrid, row, column, getValueInList(possibles, index))

      case solveVergleichsSudoku(updatedGrid, comparatorsGrid, row, column + 1) do
        nil ->
          updatedGrid = setXY(updatedGrid, row, column, 0)

          solveVergleichsSudokuWithValues(
            updatedGrid,
            comparatorsGrid,
            row,
            column,
            possibles,
            index + 1
          )

        result ->
          result
      end
    end
  end
end
