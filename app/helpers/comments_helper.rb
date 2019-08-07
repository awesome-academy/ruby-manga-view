module CommentsHelper
  def comments_tree_for comments, chapter, comment_new
    safe_join(comments.map do |comment, nested_comments|
      render(comment, chapter: chapter,
        comment_new: comment_new) + tree(nested_comments, chapter)
    end)
  end

  def tree nested_comments, chapter
    return if nested_comments.empty?
    content_tag :div,
      comments_tree_for(nested_comments, chapter, Comment.new),
      class: "replies"
  end
end
