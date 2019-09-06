defmodule VendingMachine do

  defmodule State do
    defstruct inserted: 0, returned: []

    def inserted(state) do
      state.inserted
    end

    def inserted(state, value) do
      %{ state | inserted: value }
    end

    def returned(state) do
      state.returned
    end

    def returned(state, value) do
      %{ state | returned: value }
    end
  end

  def boot() do
    %State{}
  end

  def display(machine) do
    case State.inserted(machine) do
      0 -> "INSERT COIN"
      n -> format_pennies(n)
    end
  end

  def coin_return(machine) do
    coins = State.returned(machine)
    machine = State.returned(machine, [])
    { machine, coins }
  end

  def insert_coin(machine, coin) do
    case coin_value(coin) do
      {:ok, value} -> State.inserted(machine, State.inserted(machine) + value)
      {:error} -> State.returned(machine, State.returned(machine) ++ [coin])
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
