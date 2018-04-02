defmodule MyString do
  def center(dqs_list) do
    #max_length = String.length(Enum.max_by(dqs_list, fn(dqs) -> String.length(dqs) end))
    max_length = dqs_list
      |> Enum.map(&String.length/1)
      |> Enum.max
    _center(dqs_list, max_length)
  end

  defp _center([], _max_length), do: []
  defp _center([ head | tail ], max_length) do
    length = String.length(head)
    padding_size = div(max_length - length, 2) 
    IO.puts String.rjust(head, length + padding_size, ?\s)
    _center(tail, max_length)
  end
end

MyString.center(["cat", "zebra", "elephant"])
