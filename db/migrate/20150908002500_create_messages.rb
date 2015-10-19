class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.string :message
      t.string :username
      t.timestamps null: false
    end
  end
end
