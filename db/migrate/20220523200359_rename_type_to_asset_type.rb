class RenameTypeToAssetType < ActiveRecord::Migration[6.1]
  def change
    rename_column :assets, :type, :asset_type
  end
end
