defmodule SelectProductWhenTooMuchMoneyTest do
  use ExUnit.Case

  setup do
    [ machine: VendingMachine.boot() ]
  end

  test "it accepts COLA selection when too many coins are inserted", context do
    machine = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.select_cola()

    { machine, display } = VendingMachine.display(machine)
    assert display == "THANK YOU"

    { _, display } = VendingMachine.display(machine)
    assert display == "INSERT COIN"
  end

  test "it accepts CHIPS selection when too many coins are inserted", context do
    machine = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.select_chips()

    { machine, display } = VendingMachine.display(machine)
    assert display == "THANK YOU"

    { _, display } = VendingMachine.display(machine)
    assert display == "INSERT COIN"
  end

  test "it accepts CANDY selection when too many coins are inserted", context do
    machine = context.machine
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:quarter)
    |> VendingMachine.insert_coin(:dime)
    |> VendingMachine.insert_coin(:nickel)
    |> VendingMachine.select_candy()

    { machine, display } = VendingMachine.display(machine)
    assert display == "THANK YOU"

    { _, display } = VendingMachine.display(machine)
    assert display == "INSERT COIN"
  end

end
