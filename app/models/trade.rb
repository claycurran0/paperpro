class Trade < ApplicationRecord
  belongs_to :asset
  belongs_to :portfolio
end
