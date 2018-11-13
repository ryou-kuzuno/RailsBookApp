class BooksController < ApplicationController
    #感想一覧
    def index
        @books =Bookstore.all.order(created_at: :desc)
        @impression = Impression.all.order(created_at: :desc)
    end

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
         @comment = Comment.new
        #(comments: params["comment"]["comment"]
        # )
        if @comment
            @comment = Comment.find_by(id: params[:id])
            # raise @user.inspect

        end
    end

    def new
        @book = Bookstore.new
        @impression = Impression.new
    end

    def edit
        @book = Bookstore.find_by(id: params[:id])
        @impression = Impression.find_by(id: params[:id])
    end

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

    def destroy
        @book = Bookstore.find_by(id: params[:id])
        @book.destroy
        flash[:notice] = "投稿を削除しました"
        redirect_to "/index"
    end
end
