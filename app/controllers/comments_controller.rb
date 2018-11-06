class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = "コメントを投稿しました"
      redirect_to comment.bookstore
    begin
      redirect_to :back, flash: {
        comment: comment,
        error_messages: comment.errors.full_messages
      }
    
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.bookstore, flash: { notice: "コメントが削除されました"}
  end
end
