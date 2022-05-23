class TradesController < ApplicationController
  def new
    query = BasicYahooFinance::Query.new
    ticker = params.fetch("input_ticker")
    data = query.quotes(ticker)
    price = data[ticker]['regularMarketPrice']
    quantity = params.fetch("input_quantity").to_f
    portfolio_id = params.fetch("portfolio_id")

    t = Trade.new
    t.asset_id = Asset.find_by(ticker: ticker).id
    t.price = price
    t.quantity = quantity
    t.portfolio_id = portfolio_id
    t.save

    redirect_back(fallback_location: root_path, notice: "Success! Price was #{t.price}, quantity was #{t.quantity}, portfolio was #{t.portfolio_id}, asset was #{t.asset_id}")
  end

  def index
    @trades = Trade.all
  end

end