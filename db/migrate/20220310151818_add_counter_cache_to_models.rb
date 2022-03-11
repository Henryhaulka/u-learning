class AddCounterCacheToModels < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :lessons_count, :integer, default: 0, null: false
    add_column :users, :subscriptions_count, :integer, default: 0, null: false
    add_column :users, :courses_count, :integer, default: 0, null: false
  end
end
