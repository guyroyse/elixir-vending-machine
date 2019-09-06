defmodule MultipleCoinTest do
  use ExUnit.Case

  setup do
    [ machine: VendingMachine.boot() ]
  end

  test "it displays the total value of multiple coins", context do
    display = context.machine
    |> VendingMachine.insert_coin(:nickel)
    |> VendingMachine.insert_coin(:dime)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.display()

    assert display == "0.40"
  end

  test "it displays the total value of multiple coins in dollars", context do
    display = context.machine
    |> VendingMachine.insert_coin(:nickel)
    |> VendingMachine.insert_coin(:dime)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.display()

    assert display == "1.15"
  end

  test "it displays the total value of multiple coins in tens of dollars", context do
    display = 1..45
    |> Enum.reduce(context.machine, fn _, machine -> 
      VendingMachine.insert_coin(machine, :quarter)
    end)
    |> VendingMachine.display()

    assert display == "11.25"
  end

  test "NICKELS, DIMES, and QUARTERS are not placed in the coin return", context do
    { _, coins } = context.machine
    |> VendingMachine.insert_coin(:nickel)
    |> VendingMachine.insert_coin(:dime)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.coin_return()

    assert coins == []
  end

end
