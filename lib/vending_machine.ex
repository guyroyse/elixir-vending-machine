defmodule VendingMachine do

  defmodule State do
    defstruct inserted: 0, returned: []

    def start_link do
      Agent.start_link fn -> %State{} end
    end

    def inserted(pid) do
      Agent.get pid, fn state -> state.inserted end
    end

    def inserted(pid, value) do
      Agent.update pid, fn state -> %{ state | inserted: value } end
    end

    def returned(pid) do
      Agent.get pid, fn state -> state.returned end
    end

    def returned(pid, value) do
      Agent.update pid, fn state -> %{ state | returned: value } end
    end
  end

  def start_link do
    State.start_link
  end

  def display(pid) do
    case State.inserted(pid) do
      0 -> "INSERT COIN"
      n -> format_pennies(n)
    end
  end

  def coin_return(pid) do
    coins = State.returned(pid)
    State.returned(pid, [])
    coins
  end

  def insert_coin(pid, coin) do
    case coin_value(coin) do
      {:ok, value} -> State.inserted(pid, State.inserted(pid) + value)
      {:error} -> State.returned(pid, State.returned(pid) ++ [coin])
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
