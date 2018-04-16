defmodule Weather.TableFormatter do
  import Enum, only: [ each: 2, map: 2, map_join: 3, max: 1 ]

  def print_table_for_columns(rows, headers) do
    with data_by_columns = split_into_columns(rows, headers),
         column_widths   = widths_of(data_by_columns)
    do
      IO.inspect column_widths
    end
  end

  def split_into_columns(rows, headers) do
    for header <- headers do
      printable(rows[header])
    end
  end

  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  def widths_of(columns) do
    IO.inspect columns
    for column <- columns, do: column |> map(&String.length/1) |> max
  end
end
