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

    return = calc_ROI(principal, rate, years)
    send_message(years, rate, return)
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

  def calc_ROI(principal, rate, years) do
    (principal * (1 + ((rate/100) * years)))
  end

  def send_message(years, rate, return) do
    IO.puts "After #{round(years)} at #{rate}%, the investment will be worth $#{Float.round(return, 2)}"
  end
end
