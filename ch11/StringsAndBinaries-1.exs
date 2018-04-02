defmodule MyString do
  def single_quoted?(str), do: _single_quoted?(str)

  defp _single_quoted?([]), do: true
  defp _single_quoted?([ head | tail ]) do
    if 32 <= head && head <= 126 do
      _single_quoted?(tail)
    else
      false
    end
  end
end

# Possible Solution
#
# defmodule MyString do
#   def printable_ascii(sqs), do: Enum.all?(sqs, fn ch -> ch in ? ..?~ end)
# end
