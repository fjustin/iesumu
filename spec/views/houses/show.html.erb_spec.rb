require 'rails_helper'

RSpec.describe "houses/show", type: :view do
  before(:each) do
    @house = assign(:house, House.create!(
      :name => "Name",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
