defmodule Matcher do
  def process file_name do
    lines = File.stream!("#{file_name}") |> Enum.with_index
    handle_lines(lines, %{}, [])
  end

  def handle_lines([], _, results), do: results
  def handle_lines([head|tail], cache_map = %{}, results) do
    { content, line_number } = head
    process_num = extract_process_num(content)


    case contain_duration?(content) do
      true ->
        [{ query, line } | _] = Map.get(cache_map, process_num)
        new_res = %{
          :line => line + 1,
          :query => query,
          :duration => extract_duration(content)
        }
        handle_lines(
          tail,
          cache_map,
          [new_res|results]
        )
      false ->
        handle_lines(
          tail,
          update_cache(cache_map, process_num, { content, line_number }),
          results
        )
    end
  end

  defp contain_duration?(content) do
    String.contains?(content, "duration")
  end

  def update_cache(map, process_num, _) when is_nil(process_num), do: map
  def update_cache(cache_map, process_num, {content, line_number}) do
    val = Map.get(cache_map, process_num)
    if !val do
      val = []
    end

    Map.put(cache_map, process_num, [{ content, line_number } | val])
  end

  defp extract_process_num content do
    pattern = ~r/.*\[(.*)\]:LOG:.*/
    case Regex.scan(pattern, content) do
      [[_, process_num]] -> process_num
      _ -> nil
    end
  end

  defp extract_duration content do
    pattern = ~r/.*\[.*\]:LOG:  duration: (.*)/
    case Regex.scan(pattern, content) do
      [[_, duration]] -> duration
      _ -> nil
    end
  end
end
