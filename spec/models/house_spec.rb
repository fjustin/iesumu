require 'rails_helper'

RSpec.describe House, type: :model do

  describe "シェアハウス投稿のvalidationを確認" do
    before do
      # let(:user) {User.create(email: "test@test", password: "password",username: "TEST MAN")}
    end

    let(:user) {User.create(email: "test@test", password: "password",username: "TEST MAN")}
    let(:house) {House.create(name: "text",content: "content", user_id: user.id)}
    let(:house_false) {House.new(name: "",content: "",user_id: user.id)}


    it "nameとcontentの両方があるとOK" do
      expect(house).to be_valid
    end

    it "nameとcontent両方とも空だとNG" do
      expect(house_false.save).to be_falsey
    end
  end
end
