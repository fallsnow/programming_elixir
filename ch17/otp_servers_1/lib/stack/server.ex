defmodule Stack.Server do
  use GenServer

  def init(initial_items) do
    { :ok, initial_items }
  end

  def handle_call(:pop, _, items) do
    [head | tail] = items
    { :reply, head, tail }
  end
end 
