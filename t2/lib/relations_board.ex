defmodule RelationsBoard do
  @moduledoc """
  Módulo que faz o parser do tabuleiro para extrair as informações para o solucionador
  """
  # INPUT 0001
  @row1size4 '.<>.|..<>|.<<.|..>>|'
  @row2size4 '<<..|>..>|>>..|<..<|'
  @row3size4 '.>>.|..<<|.<<.|..>>|'
  @row4size4 '<>..|>..<|>>..|<..<|'

  # INPUT 004
  @row1size6 '.<<.|..>>|.><.|..<<|.><.|..><|'
  @row2size6 '>>>.|<.><|>>>.|>.<<|>><.|<.<<|'
  @row3size6 '<<..|<..>|<<..|>..>|><..|>..>|'
  @row4size6 '.<<.|..<>|.<>.|..>>|.<<.|..>>|'
  @row5size6 '>>>.|>.><|<<<.|<.<>|><<.|<.>>|'
  @row6size6 '<>..|<..<|><..|>..>|>>..|<..<|'

  # INPUT 011
  @row1size9 '.<>.|.><>|..<<|.<>.|.<>>|..>>|.><.|.>><|..<<|'
  @row2size9 '<<<.|><<>|>.<>|<<<.|<>>>|<.><|>>>.|<<><|>.>>|'
  @row3size9 '><..|><.>|>..>|><..|<>.>|<..<|<>..|<<.<|<..>|'
  @row4size9 '.>>.|.><<|..<<|.>>.|.<><|..>>|.<<.|.>>>|..<<|'
  @row5size9 '<>>.|><<<|>.<>|<><.|<<<<|<.>>|>>>.|<>><|>.><|'
  @row6size9 '<<..|>>.>|>..<|><..|>>.>|<..<|<>..|<<.<|<..>|'
  @row7size9 '.<>.|.>>>|..><|.><.|.>><|..><|.<<.|.><>|..<<|'
  @row8size9 '<><.|<<<<|<.>>|>>>.|<<><|<.<>|><>.|><<>|>.>>|'
  @row9size9 '><..|>>.>|<..<|<<..|<<.>|>..>|<<..|>>.>|<..<|'

  @doc """
  Retorna as linhas do tabuleiro dado o tamanho dele.
  Pode ser 9, 6 ou 4
  """
  @spec allRows(integer) :: list(binary)
  def allRows(size) do
    case size do
      9 ->
        [
          @row1size9,
          @row2size9,
          @row3size9,
          @row4size9,
          @row5size9,
          @row6size9,
          @row7size9,
          @row8size9,
          @row9size9
        ]

      6 ->
        [@row1size6, @row2size6, @row3size6, @row4size6, @row5size6, @row6size6]

      4 ->
        [@row1size4, @row2size4, @row3size4, @row4size4]

      _ ->
        raise "Esse tamanho não pode!"
    end
  end

  @doc """
  Utilizando de correspondência de padrões para remover os símbolos |
  """
  @spec takePipeOut(binary) :: binary
  def takePipeOut([]), do: []

  def takePipeOut([x | xs]) when x != ?| do
    [x | takePipeOut(xs)]
  end

  def takePipeOut([_ | xs]), do: takePipeOut(xs)

  @doc """
  Utilizando de correspondência de padrões para achar apenas os símbolos de comparação
  """
  @spec takeAllComparatorsFromRow(binary) :: list(binary)
  def takeAllComparatorsFromRow([]), do: []

  def takeAllComparatorsFromRow(raw_row) do
    row = takePipeOut(raw_row)
    [Enum.take(row, 4) | takeAllComparatorsFromRow(Enum.drop(row, 4))]
  end

  @doc """
  Retorna o tabuleiro de relações
  """
  @spec getRelationsBoard() :: list(list(binary))
  def getRelationsBoard() do
    all_rows = allRows(SizeConfig.sizeBoard())
    Enum.map(all_rows, &takeAllComparatorsFromRow/1)
  end
end
