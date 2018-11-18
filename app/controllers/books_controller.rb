class BooksController < ApplicationController

    #感想一覧を表示するアクション
    def index
        @books =Bookstore.all.order(created_at: :desc)
        @impressions = Impression.all.order(created_at: :desc)
        # where(
        #     story: params[:story],
        #     impression: params[:impression]
        # )
    end

    #本の詳細画面でのアクション
    def show
        @book = Bookstore.find_by(
            id: params[:bookstore_id]
            )

        # @impressions = Impression.find_by(
        #     id: params[:id]
        #     )
        @impressions =     Impression.where(story: params[:story], impressions: params[:impressions])
        raise @impressions.inspect
        @likes_count = Like.where(
            bookstore_id: params[:impressions_id]
            ).count

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
        @book = Bookstore.find_by(id: params[:id])
        @impression = Impression.find_by(id: params[:id])
    end

    #新しい投稿を作成するアクション
    def create
        # book_idを確定させるために先に@book.saveをしておく必要がある。
        # ただし、@impression.saveが失敗した場合は、@book.saveの保存もなかったことにしたい
        @book = Bookstore.new(
            title: params["bookstore"]["title"],
            author: params["bookstore"]["author"],
            )
        @book.save

        @impression = Impression.new(
            story: params["bookstore"]["impression"]["story"],
            impressions: params["bookstore"]["impression"]["impressions"],
            user_id: params["bookstore"]["impression"]["user_id"],
            bookstore_id: @book.id
        )

        # raise @impression.inspect
        if @impression.save
            redirect_to "/index"
        else
            # @book.saveを取り消す必要がある（データを消しているだけ）
            @book.destroy
            render "new"
        end
    end

    #投稿の編集内容を反映するアクション
    def update
        @impression = Impression.find_by(id: params[:id])
        @impression.story = params[:story]
        @impression.impressions = params[:impressions]
        if params[:thumbnail]
            # @user.thumbnail = "#{@user.id}.jpg"
            thumbnail = params[:thumbnail]
            File.binwrite "public/books_images/#{@user.thumbnail}", thumbnail.read
        end

        if @impression.save
            redirect_to "/show/#{@impression.id}"
        else
            render "#{@impression.id}/edit"
        end
    end

    #投稿内容を削除するためのアクション
    def destroy
        @book = Bookstore.find_by(id: params[:id])
        @book.destroy
        flash[:notice] = "投稿を削除しました"
        redirect_to "/index"
    end
end
