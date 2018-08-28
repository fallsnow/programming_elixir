defmodule Stack.Stash do
  use GenServer

  @me __MODULE__

  def start_link(initial_number) do
    #GenServer.start_link(__MODULE__, initial_number, name: @me)
    GenServer.start_link(@me, initial_number, name: @me)
  end

  def get() do
    GenServer.call(@me, { :get })
  end

  def update(new_items) do
    GenServer.cast(@me, { :update, new_items })
  end

  # Server implementation
  
  def init(initial_items) do
    { :ok, initial_items }
  end

  def handle_call({ :get }, _from, current_items) do
    { :reply, current_items, current_items }
  end

  def handle_cast({ :update, new_items }, _current_items) do
    { :noreply, new_items }
  end

end
