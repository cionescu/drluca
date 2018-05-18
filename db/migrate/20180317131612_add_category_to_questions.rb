class AddCategoryToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :category, :integer, default: 0
  end
end
