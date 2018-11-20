class LikesController < ApplicationController

    def like
        @imp = Impression.find_by(id: params[:id])
    end

    def create
        @like = Like.new(
            user_id: @current_user.id, 
            bookstore_id: params[:bookstore_id]
        )
        @like.save
        @likes_count = Like.where(bookstore_id: @like.bookstore_id).count
        redirect_to "/show/#{params[:_id]}"

    end

    def destroy
        @like = Like.find_by(
            user_id: @current_user.id, 
            bookstore_id: params[:bookstore_id]
        )
        @like.destroy
        redirect_to "/show/#{params[:bookstore_id]}"
    end

end
