class ApplicationController < ActionController::Base
    before_action :set_current_user

    # 現在ログインしているユーザーのIDを取る
    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end

    def user_logged_in
        if @current_user.nil?
            redirect_to :root
        end
    end

    def ensure_correct_user
        if @current_user.id != params[:id].to_i
        flash[:notice] = "権限がありません"
        redirect_to("/index")
       end
    end


    # メモ
    # あるビュー依存の処理はApplicationContorollerに記述しない
    #新しく感想を投稿する画面のアクション
    def new
        @book = Bookstore.new
        @impression = Impression.new
    end

    def _footer
        @user = User.find_by(id: params[:id])
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
