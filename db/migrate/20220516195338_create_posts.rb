class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :body
      t.references :portfolio
      t.string :image_url

      t.timestamps
    end
  end
end
