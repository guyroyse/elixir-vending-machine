defmodule MakeChangeForCola do
  use ExUnit.Case

  setup do
    [ machine: VendingMachine.boot() ]
  end

  test "it makes change for COLA returning a single quarter", context do
    { _, coins } = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.select_cola()
    |> VendingMachine.coin_return()

    assert coins == [:quarter]
  end

  test "it makes change for COLA returning a multiple quarters", context do
    { _, coins } = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.select_cola()
    |> VendingMachine.coin_return()

    assert coins == [:quarter, :quarter, :quarter]
  end

  test "it makes change for COLA returning a single dime", context do
    { _, coins } = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:dime)
    |> VendingMachine.select_cola()
    |> VendingMachine.coin_return()

    assert coins == [:dime]
  end

  test "it makes change for COLA returning a multiple dimes", context do
    { _, coins } = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:dime)
    |> VendingMachine.insert_coin(:dime)
    |> VendingMachine.select_cola()
    |> VendingMachine.coin_return()

    assert coins == [:dime, :dime]
  end

  test "it makes change for COLA returning a nickel", context do
    { _, coins } = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:nickel)
    |> VendingMachine.select_cola()
    |> VendingMachine.coin_return()

    assert coins == [:nickel]
  end
end
