defmodule MultipleCoinTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = VendingMachine.start_link()
    {:ok, pid: pid}
  end

  test "it displays the total value of multiple coins", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :nickel)
    VendingMachine.insert_coin(pid, :dime)
    VendingMachine.insert_coin(pid, :quarter)
    assert VendingMachine.display(pid) == "0.40"
  end

  test "it displays the total value of multiple coins in dollars", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :nickel)
    VendingMachine.insert_coin(pid, :dime)
    VendingMachine.insert_coin(pid, :quarter)
    VendingMachine.insert_coin(pid, :quarter)
    VendingMachine.insert_coin(pid, :quarter)
    VendingMachine.insert_coin(pid, :quarter)
    assert VendingMachine.display(pid) == "1.15"
  end

  test "it displays the total value of multiple coins in tens of dollars", context do
    pid = context[:pid]
    for _n <- 1..45, do: VendingMachine.insert_coin(pid, :quarter)
    assert VendingMachine.display(pid) == "11.25"
  end

  test "NICKELS, DIMES, and QUARTERS are not placed in the coin return", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :nickel)
    VendingMachine.insert_coin(pid, :dime)
    VendingMachine.insert_coin(pid, :quarter)
    assert VendingMachine.coin_return(pid) == []
  end

end
