defmodule Stack.Impl do

  def push(current_items, new_items), do: List.flatten([[new_items] | current_items])
  def pop(items),                     do: [popped | rest] = items

end 
