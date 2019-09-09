defmodule VendingMachine do

  defstruct [
    inserted: 0,
    returned: [],
    next_display: nil
  ]

  def boot(), do: %VendingMachine{}

  def display(machine) do
    display = machine.next_display || Display.balance(machine.inserted)
    machine = Map.put(machine, :next_display, nil)
    { machine, display }
  end

  def coin_return(machine) do
    coins = machine.returned
    machine = Map.put(machine, :returned, [])
    { machine, coins }
  end

  def insert_coin(machine, coin) do
    case Coin.value(coin) do
      { :ok, value } -> 
        Map.put(machine, :inserted, machine.inserted + value)
      { :error } ->
        Map.put(machine, :returned, machine.returned ++ [coin])
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
      inserted when inserted >= price -> machine
        |> Map.put(:returned, machine.returned ++ Changer.make_change(inserted - price))
        |> Map.put(:inserted, 0)
        |> Map.put(:next_display, Display.thank_you())
      _ -> machine
        |> Map.put(:next_display, Display.price(price))
    end
  end

end

defmodule Display do

  def balance(0) do
    "INSERT COIN"
  end

  def balance(n) do
    format_pennies(n)
  end

  def thank_you() do
    "THANK YOU"
  end

  def price(n) do
    "PRICE #{format_pennies(n)}"
  end

  defp format_pennies(n) do
    {dollars, cents} = n
    |> Integer.to_string 
    |> String.pad_leading(3, "0")
    |> String.split_at(-2)

    "#{dollars}.#{cents}"
  end

end

defmodule Changer do
  def make_change(balance) do
    make_change(balance, [])
  end

  def make_change(balance, coins) when balance >= 25 do
    make_change(balance - 25, coins ++ [:quarter])
  end

  def make_change(balance, coins) when balance >= 10 do
    make_change(balance - 10, coins ++ [:dime])
  end

  def make_change(balance, coins) when balance >= 5 do
    make_change(balance - 5, coins ++ [:nickel])
  end

  def make_change(0, coins) do
    coins
  end
end

defmodule Coin do
  def value(:nickel),  do: { :ok, 5 }
  def value(:dime),    do: { :ok, 10 }
  def value(:quarter), do: { :ok, 25 }
  def value(_),        do: { :error }
end
