defmodule InvalidCoinTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = VendingMachine.start_link()
    {:ok, pid: pid}
  end

  test "it has an invalid coin when inserted", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :penny)
    assert VendingMachine.coin_return(pid) == [:penny]
  end

  test "it has invalid coins when inserted", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :penny)
    VendingMachine.insert_coin(pid, :dollar)
    VendingMachine.insert_coin(pid, :quid)
    assert VendingMachine.coin_return(pid) == [:penny, :dollar, :quid]
  end

  test "checking coin return empties it", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :penny)
    VendingMachine.insert_coin(pid, :dollar)
    VendingMachine.insert_coin(pid, :quid)
    assert VendingMachine.coin_return(pid) == [:penny, :dollar, :quid]
    assert VendingMachine.coin_return(pid) == []
  end

end
