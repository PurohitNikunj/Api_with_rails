class CommentSerializer < ActiveModel::Serializer
  attributes :id, :comment, :date_of_comment
end
