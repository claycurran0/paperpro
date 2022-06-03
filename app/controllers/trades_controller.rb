class TradesController < ApplicationController
  def new
    query = BasicYahooFinance::Query.new
    input = params.fetch("input_ticker")
    reversed_s = input.reverse;
    reversed_s =~ /^.*?\)(.*?)\(/;
    ticker = $1.reverse;
    asset_id = Asset.find_by(ticker: ticker).id
    data = query.quotes(ticker)
    price = data[ticker]['regularMarketPrice']
    quantity = params.fetch("input_quantity").to_f
    if quantity <= 0
      redirect_back(fallback_location: root_path, alert: "Trade Failed! Trade quantity must be a positive value.")
    else
      
      portfolio_id = params.fetch("portfolio_id")
      portfolio = Portfolio.find(portfolio_id)
      quantity_held = Trade.where({ :portfolio_id => portfolio_id, :asset_id => asset_id}).sum(:quantity)
      tradeType = params.fetch("tradeType", nil)
      if tradeType == "sell"
        quantity = quantity * -1
        action = "sold"
      else
        action = "bought"
      end

      t = Trade.new
      t.asset_id = asset_id
      t.price = price
      t.quantity = quantity
      t.portfolio_id = portfolio_id
      if t.price * t.quantity > portfolio.cash_balance
        redirect_back(fallback_location: root_path, alert: "Trade Failed! You don't have enough cash to buy #{quantity} shares of #{ticker}.")
      elsif (quantity * -1 > quantity_held)
        redirect_back(fallback_location: root_path, alert: "Trade Failed! You don't have #{quantity} shares of #{ticker} to sell.")
      elsif tradeType == nil
        redirect_back(fallback_location: root_path, alert: "Trade Failed! You must select a buy or sell option.")
      else
        t.save
        redirect_back(fallback_location: root_path, notice: "Success! You #{action} #{quantity.abs} shares of #{ticker} at #{price} per share.")
      end
    end
  end

  def index
    @trades = Trade.all
  end

end