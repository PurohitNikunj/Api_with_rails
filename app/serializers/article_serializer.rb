class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :owned_comment
  def owned_comment 
    self.object.comments.map do |c|
      { comment_id: c.id,
        comment: c.comment }
    end 
  end 
end
