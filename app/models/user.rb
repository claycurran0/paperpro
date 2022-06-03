class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :portfolios
  has_many(:posts, 
    :through => :portfolios
  )

  has_many(:follower_connections, :foreign_key => :leader_id, :class_name => :Follow )
  has_many(:leader_connections, :foreign_key => :follower_id, :class_name => :Follow )
  has_many(:followers, :through => :follower_connections, :class_name => :User, :source => :follower)
  has_many(:leaders, :through => :leader_connections, :class_name => :User, :source => :leader)

  
end
