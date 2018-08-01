defmodule Link do
  import :timer, only: [ sleep: 1 ]

  def sad_function(parent) do
    send parent, "dying message"
    exit(:boom)
  end
  def run do
    spawn_link(Link, :sad_function, [self()])
    sleep(500)
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happend as far as I am concerned"
    end
  end
end

Link.run
