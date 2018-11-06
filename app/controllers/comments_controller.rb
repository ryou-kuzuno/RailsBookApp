class CommentsController < ApplicationController
  
  def reply
    @comment = Comment.new(
      comment: params[:comment],
      book_id: params[:book_id],
      user_id: params[:user_id],
      displayable: params[:displayable]
    )
    @comment.save
    redirect_to :action => "show/#{@book.id}"
  end
  
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
