class Item < ApplicationRecord
  belongs_to :seler,optional: true, class_name: "User"
  belongs_to :buyer,optional: true, class_name: "User"
  has_many :images
  accepts_nested_attributes_for :images
  
  belongs_to :seler, class_name: "User", optional: true
  belongs_to :buyer, class_name: "User", optional: true
  has_many :images
  has_many :brands
  has_many :category,through: :item_categories
  has_many :item_categories
  accepts_nested_attributes_for :images,allow_destroy: true
  accepts_nested_attributes_for :brands,allow_destroy: true
  accepts_nested_attributes_for :item_categories,allow_destroy: true

  has_many :categories, through: :items_categories
  has_one :brand
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, inclusion: 300..9999999
end