defmodule Stack.Server do
  use GenServer
  alias Stack.Impl

  #def init(initial_items) do
  #  { :ok, initial_items }
  def init(_) do
    { :ok, Stack.Stash.get() }
  end

  def handle_cast({:push, new_items}, current_items) do
    items = Impl.push(current_items, new_items)
    { :noreply, items}
  end

  def handle_call(:pop, _from, items) do
    [popped | rest] = Impl.pop(items)
    { :reply, popped, rest}
  end

  def terminate(_rason, current_items) do
    Stack.Stash.update(current_items)
  end
end 
