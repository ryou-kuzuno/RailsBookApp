class CommentsController < ApplicationController
  def reply
    @book = Bookstore.find(id: params[:id])
    @comment = Comments.new
    if @comment.save
      redirect_to "/show/#{@book.id}"
    end
  end



  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.bookstore, flash: { notice: "コメントが削除されました"}
  end
end
