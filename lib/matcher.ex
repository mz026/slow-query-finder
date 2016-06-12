defmodule Matcher do
  def contain_duration?({ line, _index }) do
    String.contains?(line, "duration")
  end

  def show_process_num(file, { line, index }) do
    pattern = ~r/.*\[(.*)\].*duration:\ (.*)ms/
    case Regex.scan(pattern, line) do
      [[_, process_num, time]] ->
        nearest = nearest_line_of_process_num(file, process_num, index)
        IO.inspect time
        IO.inspect nearest
        IO.puts "-"
    end
  end

  def nearest_line_of_process_num(file, process_num, bottom_line) do
    pattern = ~r/\[#{process_num}\]:LOG/
    check_line(bottom_line - 1, pattern, file)
  end

  def check_line(line_num, pattern, file) when line_num == 0 do
    nil
  end

  def check_line(line_num, pattern, file) do
    case Regex.match?(pattern, Enum.at(file, line_num)) do
      true ->
        Enum.at(file, line_num)
      false ->
        check_line(line_num - 1, pattern, file)
    end
  end
end
