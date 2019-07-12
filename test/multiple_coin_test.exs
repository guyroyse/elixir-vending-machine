defmodule MultipleCoinTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = VendingMachine.start_link()
    {:ok, pid: pid}
  end

  test "it displays the value of a multiple coins when inserted", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :nickel)
    VendingMachine.insert_coin(pid, :dime)
    VendingMachine.insert_coin(pid, :quarter)
    assert VendingMachine.display(pid) == "0.40"
  end

  test "it displays the value of multiple coins when lots of them are inserted", context do
    pid = context[:pid]
    for _n <- 1..45, do: VendingMachine.insert_coin(pid, :quarter)
    assert VendingMachine.display(pid) == "11.25"
  end

end
