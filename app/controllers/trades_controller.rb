class TradesController < ApplicationController
  def new
    query = BasicYahooFinance::Query.new
    ticker = params.fetch("input_ticker")
    data = query.quotes(ticker)
    price = data[ticker]['regularMarketPrice']
    quantity = params.fetch("input_quantity").to_f

    t = Trade.new
    t.price = price
    t.quantity = quantity
    t.save

    redirect_back(fallback_location: root_path, notice: "Success! Price was #{price}, quantity was #{quantity}")
  end
end