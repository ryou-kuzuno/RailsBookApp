class BooksController < ApplicationController
    before_action :set_current_user

    def index
        @books =Bookstore.all.order(created_at: :desc)
    end

    def show
        @book = Bookstore.find_by(id: params[:id])
        @likes_count = Like.where(book_id: @book.id).count
    end

    def new
        @book = Bookstore.new
    end

    def edit
        @book = Bookstore.find_by(id: params[:id])
    end

    def create
        @book = Bookstore.new(
            title: params[:title],
            author: params[:author],
            story: params[:story],
            impressions: params[:impressions]
            )
        if @book.save
            redirect_to "/index"
          else
            render "/new"
        end
    end

    def update
        @book = Bookstore.find_by(id: params[:id])
        @book.story = params[:story]
        @book.impressions = params[:impressions]

        if params[:thumbnail]
            @user.thumbnail_name = "#{@user.id}.jpg"
            thumbnail = params[:thumbnail]
            File.binwrite "public/books_images/#{@user.thumbnail_name}", thumbnail.read
        end

        if @book.save
            redirect_to "/show/#{@book.id}"
        else
            render "#{@book.id}/edit"
        end
    end

    def destroy
        @book = Bookstore.find_by(id: params[:id])
        @book.destroy
        flash[:notice] = "投稿を削除しました"
        redirect_to "/index"
    end
end
