defmodule MyList do
  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from + 1, to)]

  def prime(n) do
    for p <- span(2, n), is_prime(p) , do: p
  end

  def is_prime(n), do: is_prime_like(n, n-1)

  defp is_prime_like(n, k) when k < 2, do: true
  defp is_prime_like(n, k) do
    rem(n, k) != 0 && is_prime_like(n, k-1)
  end
    
end 

MyList.prime(40)
