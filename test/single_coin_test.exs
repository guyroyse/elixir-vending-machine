defmodule SingleCoinTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = VendingMachine.start_link()
    {:ok, pid: pid}
  end

  test "it displays the value of a NICKEL", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :nickel)
    assert VendingMachine.display(pid) == "0.05"
  end

  test "it displays the value of a DIME", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :dime)
    assert VendingMachine.display(pid) == "0.10"
  end

  test "it displays the value of a QUARTER", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :quarter)
    assert VendingMachine.display(pid) == "0.25"
  end

  test "NICKELS are not placed in the coin return", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :nickel)
    assert VendingMachine.coin_return(pid) == []
  end

  test "DIMES are not placed in the coin return", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :dime)
    assert VendingMachine.coin_return(pid) == []
  end

  test "QUARTERS are not placed in the coin return", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :quarter)
    assert VendingMachine.coin_return(pid) == []
  end

end
