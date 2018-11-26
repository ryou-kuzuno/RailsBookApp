class LikesController < ApplicationController
    before_action :set_current_user

    def like
        @imp = Impression.find_by(id: params[:id])
        @likes = Like.where(bookstore_id: params[:likes][:impression],
                            user_id: @current_user.id)
    end

    def create
        @like = Like.new(
            user_id: @current_user.id, 
            bookstore_id: params[:likes][:bookstore_id]
        )
        if @like.save
            redirect_to "/show/#{params[:likes][:bookstore_id]}"
        end
    end

    def destroy
        @like = Like.find_by(
            user_id: @current_user.id, 
            # bookstore_id: params[:likes][:bookstore_id]
        )
        @like.destroy
        redirect_to "/show/#{params[:bookstore_id]}"
    end

end
