class AddParentCommenttoComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :parent_comment_id, :integer, default: :null
  end
end