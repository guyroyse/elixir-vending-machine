defmodule EmptyMachineTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = VendingMachine.start_link()
    {:ok, pid: pid}
  end

  test "it displays INSERT COIN", context do
    pid = context[:pid]
    assert VendingMachine.display(pid) == "INSERT COIN"
  end  

  test "it has not coins in the coin return", context do
    pid = context[:pid]
    assert VendingMachine.coin_return(pid) == []
  end

end
