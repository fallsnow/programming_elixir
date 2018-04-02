defmodule SimpleCSV do
  def read(filename) do
    file = File.open!(filename)
    headers = read_headers(IO.read(file, :line))
    Enum.map(IO.stream(file, :line), &(create_one_row(headers, &1)))
  end

  defp read_headers(hdr_line) do
    from_csv_and_map(hdr_line, &(String.to_atom(&1)))
  end

  defp create_one_row(headers, row_csv) do
    row = from_csv_and_map(row_csv, &(maybe_convert_numbers(&1)))
    Enum.zip(headers, row)
  end

  defp from_csv_and_map(row_csv, mapper) do
    row_csv
    |> String.strip
    |> String.split(~r{,\s*})
    |> Enum.map(mapper)
  end

  defp maybe_convert_numbers(value) do
    cond do
      Regex.match?(~r{^\d+$}, value)            -> String.to_integer(value)
      Regex.match?(~r{^\d+\.\d+$}, value)       -> String.to_float(value)
      << ?: :: utf8, name :: binary >> = value  -> String.to_atom(name)
      true -> value
    end
  end
end

defmodule Tax do
  def orders_with_total(orders, tax_rates) do
     orders |> Enum.map(&(add_total_to(&1, tax_rates)))
  end

  def add_total_to(order = [id: _, ship_to: state, net_amount: net], tax_rates) do
    tax_rate = Keyword.get(tax_rates, state, 0)
    tax = net * tax_rate
    total = net + tax
    Keyword.put(order, :total_amount, total)
  end
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

orders = SimpleCSV.read("sales_information.csv")
IO.inspect Tax.orders_with_total(orders, tax_rates)
