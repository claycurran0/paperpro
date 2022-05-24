class AddSubtitleToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :subtitle, :text
  end
end
