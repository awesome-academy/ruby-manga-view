class CommentsController < ApplicationController
  before_action :load_chapter, only: [:create, :new]
  before_action :require_login, only: %i(create destroy)
  before_action :correct_comment, only: :destroy

  def new
    @comment = Comment.new parent_id: params[:parent_id]
  end

  def create
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by id: params[:comment].delete(:parent_id)
      @comment = parent.children.build comment_params
    else
      @comment = Comment.new comment_params
    end
    @comment.chapter_id = @chapter.id
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html{redirect_to comic_chapter_url @chapter.comic, @chapter}
        format.js
      end
    else
      render "chapters/show"
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html{redirect_to request.referrer || @chapter}
        format.js
      end
    else
      flash[:danger] = t ".delete_failed"
      render "chapters/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_chapter
    @chapter = Chapter.find_by id: params[:chapter_id]

    return if @chapter
    flash[:success] = t "common.chapter_not_found"
    redirect_to root_path
  end

  def correct_comment
    @chapter = Chapter.find_by id: params[:chapter_id]
    @comment = current_user.comments.find_by id: params[:id]
    return if @comment
    flash[:danger] = t ".not_found"
    redirect_to @chapter
  end
end
