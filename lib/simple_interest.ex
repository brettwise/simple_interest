defmodule SimpleInterest do
  @moduledoc """
  This module is meant to figure simple interest.
  """

  @doc """
  Main entry point for program. This is what is typed in IEX to start the program.
  """
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

  @doc """
  Simply a wrapper for the stadard lib function.
  """
  def get_number(string) do
    IO.gets "Enter the #{string}: "
  end

  @doc """
  Takes a string and converts it to a float. Also checks to make sure what's entered is actually a number.
  """
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

  @doc """
  Simply returns the ROI list by year into the main function above.
  """
  def calc_ROI(list, _, _, years) when years <= 0 do
    list
  end

  @doc """
  Calculates the ROI at end of each year. Takes a `list`, and 3 numbers: the principal, rate, and number of years.

  ## Examples

    iex> SimpleInterest.calc_ROI([], 1500, 4.3, 4)
    
    [1775.1231702014995, 1701.9397604999997, 1631.7734999999998, 1564.5]

  """
  def calc_ROI(list, principal, rate, years) do
    principal = (principal * (1 + (rate/100)))
    calc_ROI([principal | list], principal, rate, years - 1)
  end

  @doc """
  Takes the list returned by `calc_ROI` and formats it to be output to the terminal.
  """
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
