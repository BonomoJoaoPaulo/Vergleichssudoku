defmodule Main do
  @moduledoc """
  Application Module
  """

  @doc """
  Runs the application
  """
  def run() do
    IO.puts("WELCOME TO VERGLEICHSSUDOKU SOLVER!")

    BoardPrinter.printBoard(
      VergleichsSudoku.solveVergleichsSudoku(
        VergleichsSudoku.getVergleichsSudokuGrid(SizeConfig.sizeBoard()),
        RelationsBoard.getRelationsBoard(),
        0,
        0
      )
    )
  end
end

# Check if the current module is being invoked directly
if __MODULE__ == __MODULE__ do
  Main.run()
end
