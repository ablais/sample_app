class FixColumnNameActiveUser < ActiveRecord::Migration
  def change
      rename_column :users, :active_user, :active
  end
end
