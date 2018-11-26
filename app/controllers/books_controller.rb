class BooksController < ApplicationController
    before_action :set_current_user
    #感想一覧を表示するアクション
    def index
        @books =Bookstore.all
        @impressions = Impression.all
    end

    #本の詳細画面でのアクション
    def show
        @impressions = Impression.find(params[:bookstore_id])
        #　ひと目でわかりやすい記述
        @likes_count = Like.where(
            user_id: params[:user_id],
            bookstore_id: params[:bookstore_id]
            ).count
        # raise @like_count.inspect
        @new_comment = Comment.new
        @comments = Comment.where(
            comment: params[:comment],
            user_id: params[:nicenane],
            bookstore_id: params[:bookstore_id]
            )
    end

    #新しく感想を投稿する画面のアクション
    def new
        @book = Bookstore.new
        @impression = Impression.new
    end

    #感想の編集画面のアクション
    def edit
        @impression = Impression.find_by(bookstore_id: params[:bookstore_id])
    end

    #新しい投稿を作成するアクション
    def create
        # book_idを確定させるために先に@book.saveをしておく必要がある。
        # ただし、@impression.saveが失敗した場合は、@book.saveの保存もなかったことにしたい
        @book = Bookstore.new(title: params["bookstore"]["title"],
                              author: params["bookstore"]["author"]
        )
         # bookstore.rb にて、has_many で impressions を指定しているので、@book起点でimpressionsを作成（build）することができる
        # buildはcreateに近いが、databaseにはこのタイミングで保存されない、という違いがある。
        
        impression = @book.impressions.build(
            story: params["bookstore"]["impression"]["story"],
            impressions: params["bookstore"]["impression"]["impressions"],
            user_id: params["bookstore"]["impression"]["user_id"],
            bookstore_id: @book.id
        )
        # raise  impression.inspect 
        # raise @impression.inspect
        # if @book.save
        if @book.save
            redirect_to "/index"
        else
            # 必要に応じてエラーメッセージを付与して上げる （sessionなど使うと良い
            # urlもbook/newに変更したいのでredirect_toを使ってい
            @book.destroy
            render 'books/new'
        end
    end

    #投稿の編集内容を反映するアクション
    def update
        @impression = Impression.find_by(bookstore_id: params[:bookstore_id])
        @impression.story = params[:impression][:story]
        @impression.impressions = params[:impression][:impressions]

        # raise @impression.inspect

        if @impression.save
            redirect_to "/show/#{@impression.id}"
        else
            render "#{@impression.id}/edit"
        end
    end

    #投稿に対するコメントを作成するアクション
  def reply
    # @imp = Impression.find(params[:id])
    comment_params = params["comment"].permit(:bookstore_id,:comment, :user_id)
    # commentsテーブルを取得してpermitでその中で使うカラムを検証を通るようにする。
    # raise comment_params.inspect
    @new_comment = Comment.new(comment_params)
    if @new_comment.save
      redirect_to controller: 'books', action: 'show'
      # @new_comment.save!
    end
  end


    #投稿内容を削除するためのアクション
    def destroy
        @book = Bookstore.find(params[:id])
        @impression = Impression.find(params[:id])
        @impression.destroy
        @book.destroy
        flash[:notice] = "投稿を削除しました"
        redirect_to "/index"
    end

    def search
        #ViewのFormで取得したパラメータをモデルに渡す
        @books = bookstore.search(params[:search])
    end
end
