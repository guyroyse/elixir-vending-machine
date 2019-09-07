defmodule SelectProductWhenEmptyTest do
  use ExUnit.Case

  setup do
    [ machine: VendingMachine.boot() ]
  end

  test "it rejects COLA selection when no coins are inserted", context do
    machine = VendingMachine.select_cola(context.machine)

    { machine, display } = VendingMachine.display(machine)
    assert display == "PRICE 1.00"

    { _, display } = VendingMachine.display(machine)
    assert display == "INSERT COIN"
  end

  test "it rejects CHIPS selection when no coins are inserted", context do
    machine = VendingMachine.select_chips(context.machine)

    { machine, display } = VendingMachine.display(machine)
    assert display == "PRICE 0.50"

    { _, display } = VendingMachine.display(machine)
    assert display == "INSERT COIN"
  end

  test "it rejects CANDY selection when no coins are inserted", context do
    machine = VendingMachine.select_candy(context.machine)

    { machine, display } = VendingMachine.display(machine)
    assert display == "PRICE 0.65"

    { _, display } = VendingMachine.display(machine)
    assert display == "INSERT COIN"
  end

end
