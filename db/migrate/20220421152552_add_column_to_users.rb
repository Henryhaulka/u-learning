class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :subscription_expenses, :integer, default: 0, null: false
    add_column :users, :balance, :integer, default: 0, null: false
    add_column :users, :course_income, :integer, default: 0, null: false
  end
end
