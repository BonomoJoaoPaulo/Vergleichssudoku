defmodule BoardPrinter do
  @moduledoc """
  Esse módulo imprime o tabuleiro com a solução completa
  """

  @doc """
  Imprime a lista de inteiros do tabuleiro
  """
  @spec printLine(list(integer)) :: :ok
  def printLine([]), do: IO.puts("")

  def printLine([x | xs]) do
    IO.write(x)
    IO.write(" ")
    printLine(xs)
  end

  @doc """
  Imprime o tabuleiro Sudoku
  """
  @spec printBoard(nil) :: :ok
  @spec printBoard(list(list(integer))) :: :ok
  def printBoard(nil), do: IO.puts("NENHUMA SOLUÇÃO ENCONTRADA.")

  def printBoard([x]), do: printLine(x)

  def printBoard([x | xs]) do
    printLine(x)
    printBoard(xs)
  end
end
