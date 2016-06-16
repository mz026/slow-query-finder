require Matcher

defmodule SlowQueryFinder do
  def main([file | _]) do
    IO.inspect file
    IO.inspect Matcher.process(file)
  end
end
