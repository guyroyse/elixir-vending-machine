defmodule SingleCoinTest do
  use ExUnit.Case

  setup do
    [ machine: VendingMachine.boot() ]
  end

  test "it displays the value of a NICKEL", context do
    { _, display } = context.machine
    |> VendingMachine.insert_coin(:nickel)
    |> VendingMachine.display()

    assert display == "0.05"
  end

  test "it displays the value of a DIME", context do
    { _, display } = context.machine
    |> VendingMachine.insert_coin(:dime)
    |> VendingMachine.display()

    assert display == "0.10"
  end

  test "it displays the value of a QUARTER", context do
    { _, display } = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.display()

    assert display == "0.25"
  end

  test "NICKELS are not placed in the coin return", context do
    { _, coins } = context.machine
    |> VendingMachine.insert_coin(:nickel)
    |> VendingMachine.coin_return()

    assert coins == []
  end

  test "DIMES are not placed in the coin return", context do
    { _, coins } = context.machine
    |> VendingMachine.insert_coin(:dime)
    |> VendingMachine.coin_return()

    assert coins == []
  end

  test "QUARTERS are not placed in the coin return", context do
    { _, coins } = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.coin_return()

    assert coins == []
  end

end
