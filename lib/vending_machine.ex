defmodule VendingMachine do

  defmodule State do
    defstruct inserted: 0, returned: []
  end

  def start_link do
    Agent.start_link fn -> %State{} end
  end

  def display(pid) do
    Agent.get pid, fn state ->
      case state.inserted do
        0 -> "INSERT COIN"
        n -> format_pennies(n)
      end
    end
  end

  def coin_return(pid) do
    coins = Agent.get pid, fn state -> state.returned end
    Agent.update pid, fn state ->
      %{ state | returned: [] }
    end
    coins
  end

  def insert_coin(pid, coin) do
    case coin_value(coin) do
      {:ok, value} -> 
        Agent.update pid, fn state -> 
          %{ state | inserted: state.inserted + value }
        end
      {:error} ->
        Agent.update pid, fn state ->
          %{ state | returned: state.returned ++ [coin] }
        end
    end
  end

  defp coin_value(coin) do
    case coin do
      :nickel -> {:ok, 5}
      :dime -> {:ok, 10}
      :quarter -> {:ok, 25}
      _ -> {:error}
    end
  end

  defp format_pennies(n) do
    {dollars, cents} = n
      |> Integer.to_string 
      |> String.pad_leading(3, "0")
      |> String.split_at(-2)
    "#{dollars}.#{cents}"
  end
end
