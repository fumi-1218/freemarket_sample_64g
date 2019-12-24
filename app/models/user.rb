class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :sns_credentials, dependent: :destroy
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  belongs_to_active_hash :birthyear 
  belongs_to_active_hash :birthmonth
  belongs_to_active_hash :birthday
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :card, dependent: :destroy
  accepts_nested_attributes_for :card

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :buyed_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :seling_items, -> { where("buyer_id is NULL") }, foreign_key: "seler_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seler_id", class_name: "Item"

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    user
  end

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD = /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d!@#\$%\^\&*\)\(+=._-]{6,128}\z/i
  VALID_KATAKANA = /\A[\p{katakana}\p{blank}ー－]+\z/
  VALID_PHONENUMBER = /\A\d{10}$|^\d{11}\z/
  #user
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL, message: 'error'}
  validates :password, presence: true, length: { in: 6..128 }, format: { with: VALID_PASSWORD, message: 'は英字と数字両方を含むパスワード6文字以上で設定してください'}
  validates :last_name, presence: true
  validates :fast_name, presence: true
  validates :last_name_kana, presence: true, format: { with: VALID_KATAKANA, message: 'はカタカナで入力して下さい'}
  validates :fast_name_kana, presence: true, format: { with: VALID_KATAKANA, message: 'はカタカナで入力して下さい'}
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :phone_number, presence: true, format: { with: VALID_PHONENUMBER, message: 'の入力が正しくありません'}

end