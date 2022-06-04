class AssetsController < ApplicationController
  def index
    @assets = Asset.all
  end

  def list
    database_records = []
      Asset.all.order(:ticker).each do |my_asset|
        result = { "value": my_asset.ticker, "text": "#{my_asset.name} (#{my_asset.ticker})" }
        database_records.push(result)
      end
    render json: database_records
  end

  def price
    ticker = params.fetch("ticker")
    @quantity = params.fetch("quantity").to_f
    @price = BasicYahooFinance::Query.new.quotes(ticker)[ticker]['regularMarketPrice'].to_f
    @proceeds = @price * @quantity
    puts(@price)
    respond_to do |format|
      format.js do
        render("assets/price.js.erb")
      end
    end
  end

end

