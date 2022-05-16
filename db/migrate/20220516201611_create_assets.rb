class CreateAssets < ActiveRecord::Migration[6.1]
  def change
    create_table :assets do |t|
      t.string :ticker
      t.string :name
      t.string :type
      t.string :image_url

      t.timestamps
    end
  end
end
