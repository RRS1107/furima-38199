class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'Last name is invalid. Input full-width characters' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'First name is invalid. Input full-width characters' }
    validates :family_name_kana, format: { with: /\A[ｧ-ﾝﾞﾟァ-ヶー－]+\z/, message: 'Last name kana is invalid. Input full-width katakana characters' }
    validates :first_name_kana, format: { with: /\A[ｧ-ﾝﾞﾟァ-ヶー－]+\z/, message: 'First name kana is invalid. Input full-width katakana characters' }
    validates :birth_day
  end

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'Password is invalid. Include both letters and numbers' }

  has_many :items
  has_many :logs

end