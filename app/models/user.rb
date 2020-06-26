class User < ActiveRecord::Base
    has_many :games
    validates :username, uniqueness: true
    validates :username, presence: true
    validates :first_name, presence: true, on: :create
    validates :last_name, presence: true, on: :create
    has_secure_password
end