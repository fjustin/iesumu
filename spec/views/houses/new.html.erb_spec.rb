require 'rails_helper'

RSpec.describe "houses/new", type: :view do
  before(:each) do
    assign(:house, House.new(
      :name => "MyString",
      :content => "MyText"
    ))
  end

  it "renders new house form" do
    render

    assert_select "form[action=?][method=?]", houses_path, "post" do

      assert_select "input[name=?]", "house[name]"

      assert_select "textarea[name=?]", "house[content]"
    end
  end
end
