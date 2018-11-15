class BooksController < ApplicationController

    #感想一覧を表示するアクション
    def index
        @books =Bookstore.all.order(created_at: :desc)
        @impression = Impression.all.order(created_at: :desc)
    end

    #本の詳細画面でのアクション
    def show
        @book = Bookstore.find_by(
            id: params[:id]
            )
        @impression = Impression.find_by(
            id: params[:id]
            )
        @likes_count = Like.where(
            book_id: @impression.id
            ).count
        # raise @user.inspect
        @new_comment = Comment.new
        @comments = Comment.all
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
        @book = Bookstore.new(
            title: params["bookstore"]["title"],
            author: params["bookstore"]["author"],
            )
        @impression = Impression.new(
            story: params["bookstore"]["impression"]["story"],
            impressions: params["bookstore"]["impression"]["impressions"]
        )
        if @book.save && @impression.save
            redirect_to "/index"

        else
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
