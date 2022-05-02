class AddCounterCacheToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :subscriptions_count, :integer, default: 0, null: false
  end
end
