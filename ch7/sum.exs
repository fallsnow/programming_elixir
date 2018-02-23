defmodule MyList do
  def sum([], total \\ 0), do: total
  def sum([head | tail], total), do: sum(tail, head + total)
end
