class CommentsController < ApplicationController

  #投稿に対するコメントを作成するアクション
  def reply
    @book = Bookstore.find(params[:id])
    comment_params = params["comment"].permit(:book_id,:comment, :user_id)
    # commentsテーブルを取得してpermitでその中で使うカラムを検証を通るようにする。
    # raise comment_params.inspect
    @new_comment = Comment.new(comment_params)
    if @new_comment.save
      redirect_to "/show/#{@book.id}"
      # @new_comment.save!
    end
  end

  #コメントを削除するアクション
  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.bookstore, flash: { notice: "コメントが削除されました"}
  end
end
