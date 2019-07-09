class UsersController < ApplicationController
  def show
    return if load_user

    flash[:danger] = t "common.not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create; end

  private

  def load_user
    @user = User.find_by id: params[:id]
  end

end
