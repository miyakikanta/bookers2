class UsersController < ApplicationController
  
    before_action :authenticate_user!
    before_action :correct_post,only: [:edit,:update]


  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    
   end

  
  def update
    @user = User.find(params[:id])
   if  @user.update(user_params)
    redirect_to user_path
    flash[:notice] = "You have updated user successfully" 
   else
     render :edit
   end
  end

  def index
  @users = User.all
  @book = Book.new
  @books = Book.all
  @user = current_user
  end
  
  private

  def correct_post
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end


  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end
end