require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @user = FactoryBot.build(:user)
  end

  describe '出品機能' do
    context '出品ができる時' do
      it "全ての条件を入力すると登録ができる" do
        expect(@item).to be_valid
      end
    end
    context '出品ができない時' do
      it 'imageが空だと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空だと出品できない' do
        @item.name = ""
        @item.valid? 
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'introductionが空だと出品できない' do
        @item.introduction = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Introduction can't be blank")
      end
      it 'categoryが未選択だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'item_conditionが未選択だと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it 'postageが未選択だと出品できない' do
        @item.postage_type_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage type can't be blank")
      end
      it 'prefectureが未選択だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prepareが未選択だと出品できない' do
        @item.preparation_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Preparation day can't be blank")
      end
      it 'priceが空だと出品できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range","Price is invalid. Input half-width characters")
      end
      it 'priceが全角数字だと出品できない' do
        @item.price = "２０００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range","Price is invalid. Input half-width characters")
      end
    end
  end
end