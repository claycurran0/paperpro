class Asset < ApplicationRecord
  has_many :trades

  def prices(tickers) # takes an array of ticker symbols and returns an array of hashes (ticker => price)
    query = BasicYahooFinance::Query.new
    quotes = query.quotes(tickers)

    prices =[]

    tickers.each do |t|
      price = quotes[ticker]['regularMarketPrice']
      output = { :ticker => ticker, :price => price }
      prices.push(output)
    end

    return prices
  end


end
