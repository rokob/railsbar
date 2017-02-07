class AddAuthorToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :author_id, :integer
  end
end
