class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_no_authentication, only: [:new, :create]
  before_action :can_change, only: [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      Signup.confirm_email(@user).deliver_now

      redirect_to @user, notice: "Cadastro criado com sucesso!"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Cadastro atualizado com sucesso!"
    else
      render :edit
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    # Os "pontos" no final da linha não são opcionais!
    def user_params
      params.
        require(:user).
        permit(:email, :full_name, :location, :password,
               :password_confirmation, :bio)
    end

    def can_change
      unless user_signed_in? && current_user == user
        redirect_to user_path(params[:id])
      end
    end

    def user
      @user ||= User.find(params[:id])
    end
end
