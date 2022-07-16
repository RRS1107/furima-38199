class Item < ApplicationRecord
  belongs_to :user
  #has_one :log
  has_one_attached :image

  
  validates :category_id, numericality: { other_than: 1 , message: "Category can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "Prefecture can't be blank"}
  validates :postage_type_id, numericality: { other_than: 1 , message: "Shipping fee status can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "Sales status can't be blank"}
  validates :preparation_day_id, numericality: { other_than: 1 , message: "Scheduled delivery can't be blank"}

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :prefecture
  belongs_to :postage_type
  belongs_to :condition 
  belongs_to :preparation_day

end
