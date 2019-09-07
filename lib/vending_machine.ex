defmodule VendingMachine do

  defstruct [
    inserted: 0,
    returned: [],
    next_display: nil
  ]

  def boot() do
    %VendingMachine{}
  end

  def display(machine) do
    display = format_display(machine.inserted, machine.next_display)
    machine = %VendingMachine{ machine | next_display: nil }
    { machine, display }
  end

  def coin_return(machine) do
    coins = machine.returned
    machine = %VendingMachine{ machine | returned: [] }
    { machine, coins }
  end

  def insert_coin(machine, coin) do
    case coin_value(coin) do
      {:ok, value} -> %VendingMachine{ machine | inserted: machine.inserted + value }
      {:error} -> %VendingMachine{ machine | returned: machine.returned ++ [coin] }
    end
  end

  def select_cola(machine) do
    select_product(machine, 100)
  end

  def select_chips(machine) do
    select_product(machine, 50)
  end

  def select_candy(machine) do
    select_product(machine, 65)
  end

  defp select_product(machine, price) do
    case machine.inserted do
      ^price -> %VendingMachine{ machine | inserted: 0, next_display: "THANK YOU" }
      _ -> %VendingMachine{ machine | next_display: "PRICE " <> format_pennies(price) }
    end
  end

  defp coin_value(:nickel),  do: { :ok, 5 }
  defp coin_value(:dime),    do: { :ok, 10 }
  defp coin_value(:quarter), do: { :ok, 25 }
  defp coin_value(_),        do: { :error }

  defp format_display(0 = _inserted, nil = _next_display) do
    "INSERT COIN"
  end

  defp format_display(inserted, nil = _next_display) do
    format_pennies(inserted)
  end

  defp format_display(_inserted, next_display) do
    next_display
  end

  defp format_pennies(n) do
    {dollars, cents} = n
      |> Integer.to_string 
      |> String.pad_leading(3, "0")
      |> String.split_at(-2)
    "#{dollars}.#{cents}"
  end
end
