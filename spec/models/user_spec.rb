require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe "バリデーションの挙動をテスト" do
    it "emailとpasswordの両方が設定されていればOK" do
      @user = User.new(email: "test@user",password: "000000", username: "TEST MAN")
      expect(@user.valid?).to eq(true)
    end

    it "emailが空だとNG" do
      @user = User.new(email: "",password: "000000", username: "TEST MAN")
      expect(@user.valid?).to eq(false)
    end

    it "passwordが空だとNG" do
      @user = User.new(email: "test@user", password: "", username: "TEST MAN")
      expect(@user.valid?).to eq(false)
    end

    it "usernameが空だとvalidationが働く" do
      @user = User.new(email: "test@user", password: "999999999", username: "")
      expect(@user.valid?).to eq(false)
    end
  end
end
