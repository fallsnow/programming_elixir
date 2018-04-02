defmodule MyString do
  def capitalize_sentences(binary) do
    list = Regex.scan(~r/[\w|\s]+\.\s+/, binary)
    _capitalize_sentences(list)
  end

  defp _capitalize_sentences([]), do: []
  defp _capitalize_sentences([ head | tail ]) do
    _capitalize(List.first(head))
    _capitalize_sentences(tail)
  end
  
  defp _capitalize(<< head::utf8, tail::binary >>) do
    IO.write String.upcase(<<head::utf8>>) <> String.downcase(tail)
  end
end

# A Possible Solution
#
# defmodule MyString do
#   def capitalize_sentences(string) do
#     string
#     |> String.split(%r{\.\s+})
#     |> Enum.map(&String.capitalize(&1))
#     |> Enum.join(". ")
#   end
# end

MyString.capitalize_sentences("oh. a DOG. woof. ")
