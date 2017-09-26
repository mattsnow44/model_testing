class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ""
      t.text :body, null: false, default: ""
      t.boolean :private
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
