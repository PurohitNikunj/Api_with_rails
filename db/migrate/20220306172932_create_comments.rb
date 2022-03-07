class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :comment
      t.date :date_of_comment
      t.belongs_to :article, foreign_key: true, null: false

      t.timestamps
    end
  end
end
