class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true

      t.text :text

      t.boolean :upvoted, default: false
      t.boolean :downvoted, default: false

      t.timestamps
    end
  end
end
