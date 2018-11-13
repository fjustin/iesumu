require 'rails_helper'
require 'factory_bot'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "バリデーションの挙動をテスト" do

    let(:user_right) {User.new(email: "test@user",password: "000000", username: "TEST MAN")}

    it "emailとpasswordの両方が設定されていればOK" do
      expect(user_right.save).to be_truthy
    end

    it "emailが空だとNG" do
      @user = User.new(email: "", password: "000000",username: "TEST AMN")
      expect(@user.save).to be_falsey
    end

    it "passwordが空だとNG" do
      @user = User.new(email: "test@user", password: "", username: "TEST MAN")
      expect(@user.save).to be_falsey
    end

    it "usernameが空だとvalidationが働く" do
      @user = User.new(email: "test@user", password: "999999999", username: "")
      expect(@user.save).to be_falsey
    end

    it "usernameが1文字以上10文字以内だと動く" do
      @user = User.new(email: "test@test", password: "1" * 9, username: "riho")
      expect(@user.save).to be_truthy
    end

    it "usernameが10文字以上だとvalidationに弾かれる" do
      @user = User.new(email: "test@test", password: "1" * 13, username: "testtesttest")
      expect(@user.save).to be_falsey
    end
  end

  describe "houseとの紐付け関連をテスト" do

    before do
      @user = User.create(email: "house@house",password: "househouse",username: "HOUSEMAN")
    end

    it "userを削除するうと、userが投稿したhouseも削除" do
      @user.houses.create(name: "池袋の楽しいシェアハウス",content: "池袋にある楽しいシェアハウスです")
      expect{@user.destroy}.to change{ House.count }.by(-1)
    end

  end
end
