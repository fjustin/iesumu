require 'rails_helper'
require 'factory_bot'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "バリデーションの挙動をテスト" do

    let(:user) {User.new(email: "email@user.com", password: "password", username: "TESTUSER")}

    it "emailとpasswordの両方が設定されていればOK" do
      expect(user.save).to be_truthy
    end

    it "emailが空だとNG" do
      user.email = ""
      expect(user.save).to be_falsey
    end

    it "passwordが空だとNG" do
      user.password = ""
      expect(user.save).to be_falsey
    end

    it "usernameが空だとvalidationが働く" do
      user.username = ""
      expect(user.save).to be_falsey
    end

    it "usernameが1文字以上30文字以内だと動く" do
      user.username = "riho"
      expect(user.save).to be_truthy
    end

    it "usernameが30文字以上だとvalidationに弾かれる" do
      user.username = "riho" * 10
      expect(user.save).to be_falsey
    end
  end

  describe "houseとの紐付け関連をテスト" do

    before do
      @user = User.create(email: "email@user.com",password: "111111",username: "333333")
    end

    it "userを削除するうと、userが投稿したhouseも削除" do
      @user.houses.create(name: "池袋の楽しいシェアハウス",content: "池袋にある楽しいシェアハウスです")
      expect{@user.destroy}.to change{ House.count }.by(-1)
    end

  end
end
