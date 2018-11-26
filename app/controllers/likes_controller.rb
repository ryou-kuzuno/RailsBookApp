class LikesController < ApplicationController
    before_action :set_current_user

    def like
        @imp = Impression.find_by(id: params[:id])
        @likes = Like.where(impression_id: params[:likes][:impression],
                            user_id: @current_user.id)
    end

    def create
        @like = Like.new(
            user_id: @current_user.id, 
            impression_id: params[:likes][:impression_id]
        )
        if @like.save
            redirect_to "/show/#{params[:likes][:impression_id]}"
        end
    end

    def destroy
        @like = Like.find_by(
            user_id: @current_user.id, 
            # impression_id: params[:likes][:impression_id]
        )
        @like.destroy
        redirect_to "/show/#{params[:impression_id]}"
    end

end
