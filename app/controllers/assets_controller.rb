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

end

