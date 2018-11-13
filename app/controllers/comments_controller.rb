class CommentsController < ApplicationController
  def reply
    @comment = Comments.find(id: params[:id])
  end



  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.bookstore, flash: { notice: "コメントが削除されました"}
  end
end
