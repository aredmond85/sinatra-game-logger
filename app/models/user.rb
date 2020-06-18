class User < ActiveRecord::Base
    has_many :games
    validates :username, uniqueness: true
    validates :username, presence: true
    validates :firstname, presence: true, on: :create
    validates :lastname, presence: true, on: :create
    has_secure_password
end