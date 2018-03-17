defmodule MyList do

  def flatten(list), do: _flatten(list, [])
  defp _flatten([], front), do: front
  defp _flatten([head | []], front), do: _flatten(head, front)

  defp _flatten([head | tail], front) do
    IO.inspect "_flatten(#{tail}, #{front} | #{head})"
    _flatten(tail, [front | head])
  end

  defp _flatten(head, front), do: [front | head]

#    if is_list(head) do
#      flatten(head)
#      flatten(tail)
#    else
#      flatten(tail)
#    end

end
