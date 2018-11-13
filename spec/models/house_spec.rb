require 'rails_helper'

RSpec.describe House, type: :model do

  describe "シェアハウス投稿のvalidationを確認" do
    before do
    end

    # userとhouseは度々利用するためローカル変数化
    let(:user) {User.create(email: "test@test", password: "password",username: "TEST MAN")}
    let(:house) {House.new(name: "text",content: "content", user_id: user.id)}


    it "nameとcontentの両方があるとOK" do
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

    it "contentが空だとNG" do
      house.content = ""
      expect(house.save).to be_falsey
    end

    context "シェアハウス投稿のタイトルが50文字制限" do
      it "タイトル文字制限内で無事投稿される" do
        house.name = "a" * 50
        expect(house).to be_valid
      end

      it "タイトル文字制限を超えて投稿" do
        house.name = "a" * 100
        expect(house).to be_invalid
      end
    end

    context "投稿が被った場合の挙動" do
      it "同じ投稿があってもちゃんと保存される" do
        house.save!
        dup_house = house.dup
        expect(dup_house.save).to be_truthy
      end
    end
  end
end
