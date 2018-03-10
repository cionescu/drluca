class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :url
      t.jsonb :answers
      t.string :correct

      t.timestamps
    end
  end
end
