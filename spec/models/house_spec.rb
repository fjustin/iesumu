require 'rails_helper'

RSpec.describe House, type: :model do

  describe "シェアハウス投稿のvalidationを確認" do
    before do
    end

    let(:user) {User.create(email: "test@test", password: "password",username: "TEST MAN")}
    let(:house) {House.create(name: "text",content: "content", user_id: user.id)}


    it "nameとcontentの両方があるとOK" do
      house = House.create(name: "text", content: "content",user_id: user.id)
      expect(house).to be_valid
    end

    it "nameとcontent両方とも空だとNG" do
      house.name = ""
      house.content = ""
      expect(house.save).to be_falsey
    end

    it "nameが空だとNG" do
      house.name = ""
      expect(house.save).to be_falsey
    end
  end
end
