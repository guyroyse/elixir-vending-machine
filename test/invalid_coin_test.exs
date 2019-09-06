defmodule InvalidCoinTest do
  use ExUnit.Case

  setup do
    [ machine: VendingMachine.boot() ]
  end

  test "a single invalid coin is place in the coin return", context do
    { _, coins }  = context.machine
    |> VendingMachine.insert_coin(:penny)
    |> VendingMachine.coin_return()

    assert coins == [:penny]
  end

  test "multiple multiple invalid coins are palced in the coin return", context do
    { _, coins }  = context.machine
    |> VendingMachine.insert_coin(:penny)
    |> VendingMachine.insert_coin(:dollar)
    |> VendingMachine.insert_coin(:quid)
    |> VendingMachine.coin_return()

    assert coins == [:penny, :dollar, :quid]
  end

  test "checking coin return empties it", context do
    machine = context.machine
    |> VendingMachine.insert_coin(:penny)
    |> VendingMachine.insert_coin(:dollar)
    |> VendingMachine.insert_coin(:quid)

    { machine, coins } = VendingMachine.coin_return(machine)
    assert coins == [:penny, :dollar, :quid]

    { _, coins } = VendingMachine.coin_return(machine)
    assert coins == []
  end

  test "mixed coins are either placed in the coin return or displayed", context do
    machine = context.machine
    |> VendingMachine.insert_coin(:nickel)
    |> VendingMachine.insert_coin(:dime)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:penny)
    |> VendingMachine.insert_coin(:dollar)
    |> VendingMachine.insert_coin(:quid)

    assert VendingMachine.display(machine) == "0.40"

    { _, coins } = VendingMachine.coin_return(machine)
    assert coins == [:penny, :dollar, :quid]
  end

end
