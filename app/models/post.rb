class Post < ApplicationRecord
  belongs_to :portfolio
  has_one(:author, 
    :through => :portfolio,
    :source => :user
  )

  has_rich_text :body

end
