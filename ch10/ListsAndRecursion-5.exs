defmodule MyEnum do

  def all?([], _fun), do: true
  def all?([head | tail], fun) do
    if fun.(head) do
      all?(tail, fun)
    else
      false
    end
  end

  def each([], _fun), do: [] 
  def each([head | tail], fun) do
    [fun.(head) | each(tail, fun)]
  end

  def filter([], _fun), do: []
  def filter([head | tail], fun) do
    [ if fun.(head) do head else [] end | filter(tail, fun) ]
  end

#  def split([], _n), do: []
#  def split([head | tail], n) do
#    {    
#      if head != n do
#        [head | split(tail, n)]
#      else
#        , [head | tail]
#      end
#    }
#  end
  def split(list, count), do: _split(list, [], count)
  defp _split([], front, _), do: { Enum.reverse(front), [] }
  defp _split(tail, front, 0), do: { Enum.reverse(front), tail }
  defp _split([head | tail], front, count) do
    _split(tail, [head | front], count - 1)
  end

  def take([], _n), do: []
  def take(list, n), do: _take(list, n, 1)
  defp _take([_head | _tail], n, count) when n < count, do: []
  defp _take([head | tail], n, count), do: [head | _take(tail, n, count+1)] 
end 

#MyEnum.split([1, 2, 3, 4, 5], 3)
