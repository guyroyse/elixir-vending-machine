defmodule InvalidCoinTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = VendingMachine.start_link()
    {:ok, pid: pid}
  end

  test "a single invalid coin is place in the coin return", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :penny)
    assert VendingMachine.coin_return(pid) == [:penny]
  end

  test "multiple multiple invalid coins are palced in the coin return", context do
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

  test "mixed coins are either placed in the coin return or displayed", context do
    pid = context[:pid]
    VendingMachine.insert_coin(pid, :nickel)
    VendingMachine.insert_coin(pid, :dime)
    VendingMachine.insert_coin(pid, :quarter)
    VendingMachine.insert_coin(pid, :penny)
    VendingMachine.insert_coin(pid, :dollar)
    VendingMachine.insert_coin(pid, :quid)
    assert VendingMachine.display(pid) == "0.40"
    assert VendingMachine.coin_return(pid) == [:penny, :dollar, :quid]
  end

end
