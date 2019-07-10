class UsersController < ApplicationController
  def show
    return if load_user

    flash[:danger] = t "common.not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t ".success"
      redirect_to root_path
    else
      flash[:danger] = t ".fails"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
