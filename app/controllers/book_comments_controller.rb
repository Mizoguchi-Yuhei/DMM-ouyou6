class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    # comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    comment = BookComment.find(params[:book_id])
    if comment.user == current_user
      comment.delete
    end
    redirect_to book_path(comment.book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment, :user_id)
  end
end