require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録が上手く行く時' do
      it "nicknameとemail、passwordとpassword_confiramation,family_name,first_name,family_name_kana,first_name_kana,birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "passwordが6文字以上の半角英数字混合であれば登録できる" do
        @user.password = "000aaa"
        @user.password_confirmation = "000aaa"
        expect(@user).to be_valid
      end
      it "family_nameが全角文字であれば登録できる" do
        @user.family_name = "山田"
        expect(@user).to be_valid
      end
      it "first_nameが全角文字であれば登録できる" do
        @user.first_name = "太郎"
        expect(@user).to be_valid
      end
      it "family_name_kanaが全角カナであれば登録できる" do
        @user.family_name_kana = "ヤマダ"
        expect(@user).to be_valid
      end
      it "first_name_kanaが全角カナであれば登録できる" do
        @user.first_name_kana = "タロウ"
        expect(@user).to be_valid
      end
    end

    context '新規登録が上手くいかない時' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it "emailが空だと登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it "メールアドレスに@を含まない場合は登録できない" do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00aaa"
        @user.password_confirmation = "000aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordは英数字混合でないと登録できない" do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password  is invalid. Include both letters and numbers")
      end
      it "passwordは英字のみだと登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password  is invalid. Include both letters and numbers")
      end
      it "passwordは全角文字を含むと登録できない" do
        @user.password = "AAA１１１"
        @user.password_confirmation = "AAA１１１"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password  is invalid. Include both letters and numbers")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "生年月日が空では登録できない" do
        @user.birth_day = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
      it "姓（全角）が空だと登録できない" do
        @user.family_name  = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name can't be blank"
      end
      it "姓（全角）が半角文字が含まれていると登録できない" do
        @user.family_name  = "yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name  is invalid. Input full-width characters"
      end
      it "名（全角）が空だと登録できない" do
        @user.first_name  = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it "名（全角）が半角文字が含まれていると登録できない" do
        @user.first_name  = "taro"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name  is invalid. Input full-width characters"
      end
      it "姓（カナ）が空だと登録できない" do
        @user.family_name_kana  = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name kana can't be blank"
      end
      it "姓（カナ）が半角文字が含まれていると登録できない" do
        @user.family_name_kana  = "yamada"
        @user.valid?
        expect(@user.errors.full_messages).to include "Family name kana  is invalid. Input full-width katakana characters"
      end
      it "名（カナ）が空だと登録できない" do
        @user.first_name_kana  = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
      it "名（カナ）が半角文字が含まれていると登録できない" do
        @user.first_name_kana = "taro"
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana  is invalid. Input full-width katakana characters"
      end
    end
  end
end