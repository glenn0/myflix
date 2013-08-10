require 'spec_helper'

describe Category do

  it "saves itself" do
    category = Category.new(name: "Drama")
    category.save
    Category.first.name.should == "Drama"
  end

  it { should have_many(:videos) }

end