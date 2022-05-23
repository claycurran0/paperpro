class TradesController < ApplicationController
  def new
    query = BasicYahooFinance::Query.new
    ticker = params.fetch("input_ticker")
    data = query.quotes(ticker)
    price = data[ticker]['regularMarketPrice']
    quantity = params.fetch("input_quantity").to_f
    portfolio = params.fetch("portfolio")

    t = Trade.new
    t.asset_id = Asset.find(ticker)
    t.price = price
    t.quantity = quantity
    t.portfolio_id = portfolio_id
    t.save

    redirect_back(fallback_location: root_path, notice: "Success! Price was #{price}, quantity was #{quantity}")
  end

  def index
    @trades = Trade.all
  end

end