defmodule EmptyMachineTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = VendingMachine.start_link()
    {:ok, pid: pid}
  end

  test "displays shows INSERT COIN", context do
    pid = context[:pid]
    assert VendingMachine.display(pid) == "INSERT COIN"
  end

  test "coin return is empty", context do
    pid = context[:pid]
    assert VendingMachine.coin_return(pid) == []
  end

end
