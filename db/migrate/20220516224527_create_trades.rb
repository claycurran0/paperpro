class CreateTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :trades do |t|
      t.references :asset, null: false, foreign_key: true
      t.references :portfolio, null: false, foreign_key: true
      t.float :quantity
      t.float :price

      t.timestamps
    end
  end
end
