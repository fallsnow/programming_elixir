defmodule Stack do

  @server Stack.Server

  def start_link(initial_items) do
    GenServer.start_link(@server, initial_items, name: @server)
  end

  def push(new_items) do
    GenServer.cast(@server, {:push, new_items})
  end

  def pop do
      GenServer.call(@server, :pop)
  end

end
