class TradesController < ApplicationController
  def new
    query = BasicYahooFinance::Query.new
    ticker = params.fetch("input_ticker")
    asset_id = Asset.find_by(ticker: ticker).id
    data = query.quotes(ticker)
    price = data[ticker]['regularMarketPrice']
    quantity = params.fetch("input_quantity").to_f
    portfolio_id = params.fetch("portfolio_id")
    portfolio = Portfolio.find(portfolio_id)
    quantity_held = Trade.where({ :portfolio_id => portfolio_id, :asset_id => asset_id}).sum(:quantity)

    t = Trade.new
    t.asset_id = asset_id
    t.price = price
    t.quantity = quantity
    t.portfolio_id = portfolio_id
    if t.price * t.quantity > portfolio.cash_balance
      redirect_back(fallback_location: root_path, alert: "Trade Failed! You don't have enough cash to buy #{quantity} shares of #{ticker}.")
    elsif (quantity * -1 > quantity_held)
      redirect_back(fallback_location: root_path, alert: "Trade Failed! You don't have #{quantity} shares of #{ticker} to sell.")
    else
      t.save
      redirect_back(fallback_location: root_path, notice: "Success! Price was #{t.price}, quantity was #{t.quantity}, portfolio was #{t.portfolio_id}, asset was #{t.asset_id}")
    end
  end

  def index
    @trades = Trade.all
  end

end