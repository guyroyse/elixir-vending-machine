defmodule VendingMachineTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = VendingMachine.start_link()
    {:ok, pid: pid}
  end

  describe "VendingMachine.display/1" do

    test "it displays INSERT COIN when no coins are inserted", context do
      pid = context[:pid]
      assert VendingMachine.display(pid) == "INSERT COIN"
    end

    test "it displays the value of a NICKEL when inserted", context do
      pid = context[:pid]
      VendingMachine.insert_coin(pid, :nickel)
      assert VendingMachine.display(pid) == "0.05"
    end

    test "it displays the value of a DIME when inserted", context do
      pid = context[:pid]
      VendingMachine.insert_coin(pid, :dime)
      assert VendingMachine.display(pid) == "0.10"
    end

    test "it displays the value of a QUARTER when inserted", context do
      pid = context[:pid]
      VendingMachine.insert_coin(pid, :quarter)
      assert VendingMachine.display(pid) == "0.25"
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

  describe "VendingMachine.coin_return/1" do

    test "it is empty when started", context do
      pid = context[:pid]
      assert VendingMachine.coin_return(pid) == []
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

end
