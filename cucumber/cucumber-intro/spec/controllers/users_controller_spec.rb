require 'spec_helper'

describe UsersController do

  it "should map {:controller => 'users', :action => 'index'} to /users" do
    route_for(:controller => 'users', :action => 'index').should == '/users'
  end

  describe UsersController, 'handling GET /users' do
    before do
      @user = mock_model(User)
      User.stub(:find).and_return([@user])
    end
    
    def do_get
      get :index
    end

    it 'should be successful' do
      do_get
      response.should be_success
    end
    it 'should render index template' do
      do_get
      response.should render_template('index')
    end

    it 'should find all users' do
      User.should_receive(:find).with(:all).and_return([@user])
      do_get
    end

    it 'should assign the found users for the view' do
      do_get
      assigns(:users).should == [@user]
    end
  end
end
