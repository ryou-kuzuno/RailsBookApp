class LikesController < ApplicationController
    before_action :set_current_user

    def like
        @imp = Impression.find_by(id: params[:id])
    end

    def create
        @like = Like.new(
            user_id: params[:likes][:user_id],
            impression_id: params[:likes][:impression_id]
        )
        if @like.save
            redirect_to "/show/#{params[:likes][:bookstore_id]}"
        end
    end

    def destroy
        @like = Like.find_by(
            user_id: params[:likes][:user_id],
            impression_id: params[:likes][:impression_id]
        )
        @like.destroy
        redirect_to "/show/#{params[:likes][:bookstore_id]}"
    end

end
