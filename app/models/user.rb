class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :to_do_lists, dependent: :destroy
  has_many :evaluations, dependent: :destroy
  has_many :notices, through: :users_notice
  has_one :card, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :notifications, dependent: :destroy   
end