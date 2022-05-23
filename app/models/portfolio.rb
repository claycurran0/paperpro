class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :trades

  def cash_balance
    balance = 1000000
    self.trades.each do |t|
      cashflow = t.quantity * t.price
      balance = balance - cashflow
    end

    return balance
  end

  def quotes(tickers)
    query = BasicYahooFinance::Query.new
    quotes = query.quotes(tickers)
    return quotes
  end

  def holdings
    holdings = []
    tickers = []

    Asset.all.each do |a|
      quantity = Trade.where({ :portfolio_id => self.id, :asset_id => a.id}).sum(:quantity)
      if quantity > 0
        output = { :asset => a, :quantity => quantity }
        holdings.push(output)
        tickers.push(a.ticker) 
      end
    end

    quotes = quotes(tickers)

    holdings.each do |h|
      ticker = h[:asset].ticker
      price = quotes[ticker]['regularMarketPrice']
      h[:current_price] = price
    end

    return holdings
  end
end
