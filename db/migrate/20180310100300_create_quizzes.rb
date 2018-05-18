class CreateQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :quizzes do |t|
      t.string :name
      t.jsonb :questions
      t.integer :current_question
      t.integer :status

      t.timestamps
    end
  end
end
