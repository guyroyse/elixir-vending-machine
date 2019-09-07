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

end
