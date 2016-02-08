defmodule SimpleInterest do
  def main do
    principal =
      get_number("principal")
      |>convert_to_float

    rate      =
      get_number("rate of interest")
      |>convert_to_float

    years     =
    get_number("number of years")
      |>convert_to_float

    calc_ROI([], principal, rate, years)
    |> format_list
    |> send_message(years, rate)
    exit(:normal)
  end

  def get_number(string) do
    IO.gets "Enter the #{string}: "
  end

  def convert_to_float(string) do
    try do
      {float, _} = Float.parse(string)
      float
    rescue
      _ ->
        IO.puts "Whoa mang, that doesn't look like a number. Let's try again."
        main
    end
  end

  def calc_ROI(list, _, _, years) when years <= 0 do
    list
  end

  def calc_ROI(list, principal, rate, years) do
    principal = (principal * (1 + (rate/100)))
    calc_ROI([principal | list], principal, rate, years - 1)
  end

  def format_list(list) do
    list
    |> Enum.map(fn(x) -> Float.to_string(x, [decimals: 2, compact: true]) end)
    |> Enum.reverse
    |> Enum.map(fn(x) -> "$" <> x <> " " end)
  end

  def send_message(list, years, rate) do
    IO.puts "After #{round(years)} years at #{rate}%, the investment will be worth the following at the end of each year: #{list}"
  end
end
