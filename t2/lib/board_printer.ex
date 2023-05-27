defmodule BoardPrinter do
  @moduledoc """
  This module pretty prints the board and its solution
  """

  @doc """
  Prints a list of integers of the board
  """
  @spec printLine(list(integer)) :: :ok
  def printLine([]), do: IO.puts("")

  def printLine([x | xs]) do
    IO.write(x)
    IO.write(" ")
    printLine(xs)
  end

  @doc """
  Prints the Sudoku board
  """
  @spec printBoard(nil) :: :ok
  @spec printBoard(list(list(integer))) :: :ok
  def printBoard(nil), do: IO.puts("NENHUMA SOLUÇÃO ENCONTRADA.")

  def printBoard([x | xs]) do
    printLine(x)

    case xs do
      [] -> printLine(x)
      _ -> printBoard(xs)
    end
  end
end
