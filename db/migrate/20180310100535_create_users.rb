class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.references :question, index: true, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
