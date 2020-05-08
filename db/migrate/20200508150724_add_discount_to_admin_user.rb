class AddDiscountToAdminUser < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :discount, :decimal, precision: 5, scale: 2, :null => false, :default => 2.00
  end
end
