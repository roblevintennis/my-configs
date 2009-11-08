class UsersController < ApplicationController
  def index
    @users = User.find(:all)
  end
end
