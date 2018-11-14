class ApplicationController < ActionController::Base
    before_action :set_current_user
    #現在ログインしているユーザーのIDを取る
    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end

    def _footer
        @user = User.find_by(id: params[:id])
    end

end
