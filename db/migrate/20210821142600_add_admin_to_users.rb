class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    ## 8.5.1 管理権限属性を追加
    #add_column :users, :admin, :boolean
    add_column :users, :admin, :boolean, default: false
  end
end
