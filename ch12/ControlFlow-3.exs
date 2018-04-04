defmodule ControlFlow do
  def ok!(param) do
    case param do
      {:ok, data} -> data
      true -> raise "#{param}"
    end
  end
end

