class UsersController < ApplicationController
    # before_action :set_current_user, only: [:show]
    before_action :ensure_correct_user, {only: [:edit, :update]}

    # loginしていない場合は処理できないようにする
    before_action :user_logged_in, only: [:show, :edit]

    # # before_action :set_current_user

    # # 現在ログインしているユーザーのIDを取る
    # def set_current_user
    #     @current_user = User.find_by(id: session[:user_id])

    #     if @current_user.nil?
    #         redirect_to root
    #     end
    # end

    def show
      @user = User.find_by(id: params[:id])
      @impressions = Impression.where(user_id: params[:id])
    end

    def new
      @user = User.new
      # if @user.save なんかついてた、コメントアウトでうまくいった。
      #   redirect_to "/index"
      # end
    end

    # 新規登録
    def create
      # "user"=>{"nicename"=>"kuzuno", "mail"=>"kuzuno@ryou", "password"=>"kuzuno"}, "commit"=>"新規登録 ", "controller"=>"users", "action"=>"create"}
      #form_forでの取り出し方
      @user = User.new(
        nicename: params["user"]["nicename"],
        mail: params["user"]["mail"],
        # thumbnail: "イメージ画像",
        password: params["user"]["password"]
      )
      if @user.save
          session[:user_id] = @user.id
          flash[:notice] = "ユーザー登録が完了しました"
          redirect_to "/index"
      else
          render("signup")
      end
    end

    def edit
      @user = User.find_by(id: @current_user.id)
    end

    def update
      @user = User.find_by(id: @current_user.id)
      @user.mail =  params[:user][:mail]
      @user.nicename =  params[:user][:nicename]
      
      # raise @user.inspect @userに値が入らない。paramsで値はとれている。
      if @user.save
        flash[:notice] = "ユーザー情報を編集しました"
        redirect_to "/users/#{@user.id}"
      else
        render "users/#{@user.id}/edit"
      end
    end

    def login_form
      @user = User.new
    end

    def login
      @user = User.find_by(
        mail: params["user"]["mail"],
        password: params["user"]["password"]
      )
      # raise @user.inspect
      if @user
        session[:user_id] = @user.id
        flash[:notice] = "ログインしました"
        redirect_to "/index"
      else
        @error_message = "メールアドレスまたはパスワードが間違っています"
        # @user = という処理がないので、html側で@userがnilになってしまっている
        @user = User.new
        @user.mail = params["user"]["mail"]
        @user.password = params["user"]["password"]
        # @user.age = params["user"]["age"] # => 25
        render "users/login_form"
      end
    end

    def logout
      session[:user_id] = nil
      flash[:notice] = "ログアウトしました"
      redirect_to "/index"
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
