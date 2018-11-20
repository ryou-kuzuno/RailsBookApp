class LikesController < ApplicationController
    before_action :set_current_user

    def like
        @imp = Impression.find_by(id: params[:id])
    end

    def create
        @like = Like.new(
            user_id: @current_user.id, 
            bookstore_id: params[:bookstore_id]
        )
        @like.save
        redirect_to "/show/#{params[:bookstore_id]}"
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
