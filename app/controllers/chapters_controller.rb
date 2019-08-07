class ChaptersController < ApplicationController
  before_action :load_chapter, only: :show

  def index
    @chapters = @comic.chapters.sort_by_name.page(params[:page])
                      .per Settings.chapter.per_page_default
  end

  def show
    @comment = Comment.new
    @comments = @chapter.comments.hash_tree
  end

  private

  def load_chapter
    return if (@chapter = Chapter.find_by id: params[:id])

    flash[:danger] = t "common.chapter_not_found"
    redirect_to comics_url
  end
end
