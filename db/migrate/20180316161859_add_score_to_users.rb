class AddScoreToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :score, :jsonb, default: []
  end
end
