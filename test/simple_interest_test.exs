defmodule SimpleInterestTest do
  use ExUnit.Case

  test "pass in principal, rate, and years as 3 floats and return ROI + principal" do
    assert SimpleInterest.calc_ROI(1500, 4.3, 4) == 1758.0
  end
end
