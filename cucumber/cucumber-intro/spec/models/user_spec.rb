require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "Bob"
    }
    @existing_user = User.create(@valid_attributes)
  end

  it 'should enforce the uniqueness of user names' do
    new_user = User.new(:name => 'Bob')
    new_user.should_not be_valid
  end
end
