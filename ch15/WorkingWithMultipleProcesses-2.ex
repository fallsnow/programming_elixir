defmodule MultiProcess do
  def send_back do
    receive do
      {sender, token} ->
        IO.puts "#{inspect self()} received #{token} from #{inspect sender}."
        send sender, {self(), token}
    end
  end

  def create_processes do
    p1 = spawn(MultiProcess, :send_back, [])
    p2 = spawn(MultiProcess, :send_back, [])

    greet p1, "fred"
    greet p2, "betty"
  end

  def greet(pid, token) do
    send pid, {self(), token}

    receive do
      {sender, token} ->
        IO.puts "#{token} has been sent back to #{inspect self()} from #{inspect sender}."
    after 2000 ->
      "No messeages have been received after 2 secondes."
    end
  end

end
