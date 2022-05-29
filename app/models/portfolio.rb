class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :trades
  has_many :posts

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

    Asset.all.each do |a|
      quantity = Trade.where({ :portfolio_id => self.id, :asset_id => a.id}).sum(:quantity)
      if quantity > 0
        output = { :asset => a, :quantity => quantity }
        holdings.push(output)
      end
    end
    return holdings
  end

  def marks(quotes)

    holdings = self.holdings

    holdings.each do |h|
      ticker = h[:asset].ticker
      price = quotes[ticker]['regularMarketPrice']
      h[:current_price] = price
      h[:market_value] = price * h[:quantity]
    end

    return holdings
  end

  def tickers
    holdings = self.holdings
    tickers = []
    holdings.each do |h|
      ticker = h[:asset][:ticker]
      tickers.push(ticker)
    end
    return tickers
  end

  def market_value(marks)
    market_value = marks.map { |h| h[:market_value] }.sum
    return market_value
  end

  def total_return_percentage(marks)
    mv = self.market_value(marks)
    cash = self.cash_balance
    total_return = mv + cash - 1000000
    trp = total_return / 1000000
    return trp
  end

end
