require 'rails_helper'

RSpec.describe LogDestination, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @log_destination = FactoryBot.build(:log_destination, user_id:user.id, item_id: item.id)
    sleep 0.1
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@log_destination).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @log_destination.user_id = 1
        expect(@log_destination).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @log_destination.item_id = 1
        expect(@log_destination).to be_valid
      end
      it '郵便番号が「3桁＋ハイフン＋4桁」の組み合わせであれば保存できる' do
        @log_destination.post_code = '123-4560'
        expect(@log_destination).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @log_destination.prefecture_id = 2
        expect(@log_destination).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @log_destination.city = '横浜市'
        expect(@log_destination).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @log_destination.address = '旭区１２３'
        expect(@log_destination).to be_valid
      end
      it '建物名が空でも保存できる' do
        @log_destination.building_name = nil
        expect(@log_destination).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @log_destination.phone_number = 12_345_678_910
        expect(@log_destination).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @log_destination.user_id = nil
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @log_destination.item_id = nil
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @log_destination.post_code = nil
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include("Post code can't be blank", 'Post code is invalid. Include hyphen(-)')
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @log_destination.post_code = 1_234_567
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @log_destination.prefecture_id = 1
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が空だと保存できないこと' do
        @log_destination.prefecture_id = nil
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @log_destination.city = nil
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @log_destination.address = nil
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @log_destination.phone_number = nil
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が9桁以下では購入できない' do
        @log_destination.phone_number = '123456789'
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include("Phone number is too short")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @log_destination.phone_number = '123 - 1234 - 1234'
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @log_destination.phone_number = 12_345_678_910_123_111
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @log_destination.token = nil
        @log_destination.valid?
        expect(@log_destination.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end