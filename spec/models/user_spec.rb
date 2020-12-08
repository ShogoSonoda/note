require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nickname,email,passwordが存在する' do
        expect(@user).to be_valid
      end

      it 'nicknameが１０文字以下' do
        @user.nickname = "aaaaaaaaaa"
        expect(@user).to be_valid
      end

      it 'passwordが６文字以上' do
        @user.password = "aaa000"
        expect(@user).to be_valid
      end

      it '確認用passwordが入力されている' do
        @user.password = "aaa000"
        @user.password_confirmation = "aaa000"
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'nicknameが１１文字以上' do
        @user.nickname = "aaaaaaaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is too long (maximum is 10 characters)")
      end

      it 'emailが空' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailに@がない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'emailが他のユーザーと被っている' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'passwordが５文字以下' do
        @user.password = "aaa00"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'passwordが半角英数字混合でない' do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include()
      end

      it 'passwordと確認用passwordが一致しない' do
        @user.password = "aaa111"
        @user.password_confirmation = "bbb111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
