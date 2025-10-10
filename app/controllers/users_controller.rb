class UsersController < ApplicationController
  before_action :require_login, except: [ :new, :create ]
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :require_correct_user, only: [ :edit, :update ]
  before_action :require_admin, only: [ :destroy ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end
  def destroy
    @user.destroy
    redirect_to movies_url, status: :see_other, alert: "Account was successfully deleted."
  end

  private

  def require_correct_user
      redirect_to root_url, status: :see_other unless current_user?(@user)
  end

  private
  def user_params
    params.expect(user: [ :name, :email, :password, :password_confirmation, :username ])
  end
  def set_user
    @user = User.find(params[:id])
  end
end
