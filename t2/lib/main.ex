defmodule Main do
  @moduledoc """
  Application Module
  """
  #import SizeConfig, only: [sizeBoard/0]
  #import RelationsBoard, only: [getRelationsBoard/0]
  #import Vergleichssudoku, only: [getVergleichsSudokuGrid/1, solveVergleichsSudoku/4]
  #import BoardPrinter, only: [print_board/1]

  @doc """
  Runs the application
  """
  def run() do
    IO.puts("WELCOME TO VERGLEICHSSUDOKU SOLVER!")

    #printBoard(
    #  solveVergleichsSudoku(getVergleichsSudokuGrid(sizeBoard()), getRelationsBoard(), 0, 0)
    #)
  end
end

# Check if the current module is being invoked directly
if __MODULE__ == __MODULE__ do
  Main.run()
end
