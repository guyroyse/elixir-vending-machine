defmodule SelectProductWhenEmptyTest do
  use ExUnit.Case

  setup do
    [ machine: VendingMachine.boot() ]
  end

  test "it rejects COLA selection when insufficient coins are inserted", context do
    machine = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.select_cola()

    { machine, display } = VendingMachine.display(machine)
    assert display == "PRICE 1.00"

    { _, display } = VendingMachine.display(machine)
    assert display == "INSERT COIN"
  end

  test "it rejects CHIPS selection when insufficient coins are inserted", context do
    machine = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.select_chips(context.machine)

    { machine, display } = VendingMachine.display(machine)
    assert display == "PRICE 0.50"

    { _, display } = VendingMachine.display(machine)
    assert display == "INSERT COIN"
  end

  test "it rejects CANDY selection when insufficient coins are inserted", context do
    machine = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.select_candy(context.machine)

    { machine, display } = VendingMachine.display(machine)
    assert display == "PRICE 0.65"

    { _, display } = VendingMachine.display(machine)
    assert display == "INSERT COIN"
  end

end
