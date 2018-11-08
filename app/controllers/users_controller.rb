class UsersController < ApplicationController

    before_action :ensure_correct_user, {only: [:edit, :update]}

    def show
      @user = User.find_by(id: params[:id])
    end

    def new
      @user = User.new
      if @user.save
        redirect_to "/index"
      end
    end

    def create
      @user = User.new(
        nicename: params[:nicename],
        mail: params[:mail],
        # thumbnail: "イメージ画像",
        password: params[:password]
      )
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "ユーザー登録が完了しました"
        redirect_to controller: :users, action: :show
      else
        render "users/new"
      end
    end

    def edit
      @user = User.find_by(id: params[:id])
    end

    def update
      @user = User.find_by(id: params[:id])
      @user.nicename = params[:nicename]
      @user.mail = params[:mail]

      if @user.save
        flash[:notice] = "ユーザー情報を編集しました"
        redirect_to "/users/#{@user.id}"
      else
        render "users/#{@user.id}/edit"
      end
    end
    
    def login_form
        @user =User.new

    end
    
    def login
      @user = User.find_by(
        mail: params[:mail], 
        password: params[:password]
      )
      if @user
        session[:user_id] = @user.id
        flash[:notice] = "ログインしました"
        redirect_to "/index"
      else
        @error_message = "メールアドレスまたはパスワードが間違っています"
        @mail = params[:mail]
        @password = params[:password]
        render "users/login_form"
      end
    end
    
    def logout
      session[:user_id] = nil
      flash[:notice] = "ログアウトしました"
      redirect_to "/login"
    end

    def likes
      @user = User.find_by(id: params[:id])
      @likes = Like.where(user_id: @user.id)
    end

    def ensure_correct_user
      if @current_user.id != params[:id].to_i
        flash[:notice] = "権限がありません"
        redirect_to "/index"
      end
    end

end
