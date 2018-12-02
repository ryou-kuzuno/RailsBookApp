class BooksController < ApplicationController
    before_action :set_current_user
    #感想一覧を表示するアクション
    def index
        @books =Bookstore.all
        @test = Bookstore.all.last(2)
        @impressions = Impression.all
    end

    #本の詳細画面でのアクション
    def show
        @book = Bookstore.find(params[:bookstore_id])
        @user = User.find_by(id: @book.user_id)
        #　ひと目でわかりやすい記述
        # @bookというインスタンスに紐づく感想の一覧にアクセスして、@impressionsに代入しているだけ
        # 本 ♡5
        #  + 感想1 ♡2
        #      + like1（user = くずの）
        #      + like2（user = たなか）
        #  + 感想2 ♡3
        #      + like3（user = くずの）
        #      + like4
        #      + like5
        @impressions = @book.impressions
        @likes_count = Like.where(
            # user_id: @current_user.id,
            bookstore_id: params[:bookstore_id]
            ).count
        # likeできるかどうかの判定
        @can_like = false
        @impressions.each do |impression|
            can_like = Like.find_by(
                user_id: @current_user.id,
                impression_id: impression.id
            )
            if can_like == 0
                @can_like = true # ある感想に紐づくLikeがなければ、Likeを追加できる
                break
            end
        end
        @new_comment = Comment.new
        # Comment.where ◯◯という条件でcommentsテーブルを検索する
        # Commentに関しては、誰が書いたか、というよりはどの本のコメントなのかさえわかれば良い
        @comments = Comment.where(
            # comments: params[:comments],
            # user_id: params[:user_id],
            bookstore_id: params[:bookstore_id]
            )
    end

    #新しく感想を投稿する画面のアクション
    def new
        # 既にあるbookstoreの情報を下地にimpressionを作りたいので、欲しいbookstoreを取得する。
        # if @book = Bookstore.find(params[:bookstore_id])
        #     @book = Bookstore.find(params[:bookstore_id])
        # else 
        @book = Bookstore.new
        @impression = Impression.new
    end

    #感想の編集画面のアクション
    def edit
        # こちらでbookstore_idに対応する@impressionが無いことがエラーの原因
        # id で検索をかけると、impression_idでの検索となってしまう。	
        # bookstore_idでの検索なので、idをbookstore_idに変更
        @impression = Impression.find_by(bookstore_id: params[:bookstore_id])
    end

    #新しい投稿を作成するアクション
    def create
        # if @book = Bookstore.find(params[:bookstore_id])
        # else
            # book_idを確定させるために先に@book.saveをしておく必要がある。
            # ただし、@impression.saveが失敗した場合は、@book.saveの保存もなかったことにしたい
            @book = Bookstore.new(title: params["bookstore"]["title"],
                                author: params["bookstore"]["author"],
                                thumbnail: params["bookstore"]["thumbnailobject"],
                                user_id: @current_user.id
            )

            # bookstore.rb にて、has_many で impressions を指定しているので、@book起点でimpressionsを作成（build）することができる
            # buildはcreateに近いが、databaseにはこのタイミングで保存されない、という違いがある。
            impression = @book.impressions.build(
                story: params["bookstore"]["impression"]["story"],
                impressions: params["bookstore"]["impression"]["impressions"],
                user_id: @current_user.id,
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
        # @book = Bookstore.find(params[:id])
        comment_params = params["comment"].permit(:bookstore_id, :comments, :user_id)

        # raise comment_params.inspect
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
        @books = Bookstore.search(params[:search_key])
        if @books
            redirect_to "/search/#{params[:search_key]}"
        else
            @books = Bookstore.all
            redirect_to "/search/#{params[:search_key]}"
        end
    end

    def search_page
        search_key_word = params[:search_key]
        @books = Bookstore.where("title LIKE ?", "%#{search_key_word}%")
        if  @books.empty?
            @message = "キーワードに該当するページが見つかりません"
            redirect_to :action => "not_found"
        end
    end

    def not_found
    end
end
