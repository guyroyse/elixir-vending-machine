defmodule EmptyMachineTest do
  use ExUnit.Case

  setup do
    [ machine: VendingMachine.boot() ]
  end

  test "it displays INSERT COIN", context do
    display = context.machine
    |> VendingMachine.display()

    assert display == "INSERT COIN"
  end  

  test "it has not coins in the coin return", context do
    { _, coins } = context.machine
    |> VendingMachine.coin_return()
    
    assert coins == []
  end

end
