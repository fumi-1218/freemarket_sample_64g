class UsersController < ApplicationController
  def index
  end

  def create
    @user = User.new
  end
end
