class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update]
  
  def edit
    @user = User.find(params[:id])
    if (current_user != @user)
      redirect_to root_path
    end
  end
  
  def update
        @user = User.find(params[:id])
    if (current_user != @user)
      redirect_to root_path
    end
    if (@user.update(user_profile))
      flash[:sucess] =  "save_suceed"
      redirect_to :edit
    end
  end
    
    
    
  def new
    @user = User.new
  end
  
  def show # 追加
   @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
