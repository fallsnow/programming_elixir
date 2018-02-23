defmodule MyList do
  def max([x]), do: x
  def max([head | tail]), do: _max(head, tail)

  defp _max(value, []), do: value
  defp _max(value, [head | tail]) when value > head, do: _max(value, tail)
  defp _max(value, [head | tail]) when value <=  head, do: _max(head, tail)
end

