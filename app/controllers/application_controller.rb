class ApplicationController < ActionController::Base
    before_action :set_current_user
    #現在ログインしているユーザーのIDを取る
    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end

    def _footer
        @user = User.find_by(id: params[:id])
    end

    def search
        @books = Bookstore.search(params[:search])
        if @books.save
            redirect_to "/search/#{@books.id}"
        end
        # @books = bookstore.all
        # #ViewのFormで取得したパラメータをモデルに渡す
        # @books = bookstore.search(params[:search])
    end

    def search_page
        #ViewのFormで取得したパラメータをモデルに渡す
        @books = Bookstore.search(params[:search])
    end

    private
    def bookstore_params
        params.require(:bookstore).permit(:title, :author)
    end

end
