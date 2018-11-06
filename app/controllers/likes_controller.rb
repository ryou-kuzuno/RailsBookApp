class LikesController < ApplicationController

    def like
        @book = Bookstore.fin_by(id: params[:id])
    end

    def create
        @like = Like.new(
            user_id: @current_user.id, 
            book_id: params[:book_id]
        )
        @like.save
        redirect_to "/show/#{params[:book_id]}"
        @likes_count = Like.where(book_id: @like.book_id).count

    end

    def destroy
        @like = Like.find_by(
            user_id: @current_user.id, 
            book_id: params[:book_id]
        )
        @like.destroy
        redirect_to "/show/#{params[:book_id]}"
    end

end
