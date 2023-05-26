alias SizeConfig, as: SizeConfig

defmodule RelationsBoard do
  def get_relations do
    board_size = SizeConfig.size_board()

    if board_size == 4 do
      row1size4 = ".<>.|..<>|.<<.|..>>|"
      row2size4 = "<<..|>..>|>>..|<..<|"
      row3size4 = ".>>.|..<<|.<<.|..>>|"
      row4size4 = "<>..|>..<|>>..|<..<|"
      [row1size4, row2size4, row3size4, row4size4]
    else
      if board_size == 6 do
        row1size6 = ".<<.|..>>|.><.|..<<|.><.|..><|"
        row2size6 = ">>>.|<.><|>>>.|>.<<|>><.|<.<<|"
        row3size6 = "<<..|<..>|<<..|>..>|><..|>..>|"
        row4size6 = ".<<.|..<>|.<>.|..>>|.<<.|..>>|"
        row5size6 = ">>>.|>.><|<<<.|<.<>|><<.|<.>>|"
        row6size6 = "<>..|<..<|><..|>..>|>>..|<..<|"
        [row1size6, row2size6, row3size6, row4size6, row5size6, row6size6]
      else
        if board_size == 9 do
          row1size9 = ".<>.|.><>|..<<|.<>.|.<>>|..>>|.><.|.>><|..<<|"
          row2size9 = "<<<.|><<>|>.<>|<<<.|<>>>|<.><|>>>.|<<><|>.>>|"
          row3size9 = "><..|><.>|>..>|><..|<>.>|<..<|<>..|<<.<|<..>|"
          row4size9 = ".>>.|.><<|..<<|.>>.|.<><|..>>|.<<.|.>>>|..<<|"
          row5size9 = "<>>.|><<<|>.<>|<><.|<<<<|<.>>|>>>.|<>><|>.><|"
          row6size9 = "<<..|>>.>|>..<|><..|>>.>|<..<|<>..|<<.<|<..>|"
          row7size9 = ".<>.|.>>>|..><|.><.|.>><|..><|.<<.|.><>|..<<|"
          row8size9 = "<><.|<<<<|<.>>|>>>.|<<><|<.<>|><>.|><<>|>.>>|"
          row9size9 = "><..|>>.>|<..<|<<..|<<.>|>..>|<<..|>>.>|<..<|"
          [row1size9, row2size9, row3size9, row4size9, row5size9, row6size9, row7size9, row8size9, row9size9]
        else
          ["Tamanho de tabuleiro inválido."]
        end
      end
    end
  end

  def take_pipe_out([]), do: []

  def take_pipe_out([x | xs]) when x != '|' do
    [x | take_pipe_out(xs)]
  end

  def take_pipe_out([_ | xs]), do: take_pipe_out(xs)

  def take_all_comparators_from_row([]), do: []

  def take_all_comparators_from_row(raw_row) do
    row = take_pipe_out(raw_row)
    [Enum.take(row, 4) | take_all_comparators_from_row(Enum.drop(row, 4))]
  end

  def get_relations_board do
    all_rows = get_relations()
    Enum.map(all_rows, &take_all_comparators_from_row/1)
  end
end
