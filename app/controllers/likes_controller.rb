class LikesController < ApplicationController
    #before_action :authenticate_user

    def create
        @like = Like.new(
            user_id: @current_user.id, 
            book_id: params[:book_id]
            )
        @like.save
        redirect_to "/show/#{params[:book_id]}"
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
