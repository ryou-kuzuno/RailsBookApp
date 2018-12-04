class CommentsController < ApplicationController
  before_action :set_current_user
  # bookstore.controller.rbにある。

  #コメントを削除するアクション
  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.bookstore, flash: { notice: "コメントが削除されました"}
  end

end
