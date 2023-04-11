class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.string :description
      t.date :arrival_date
      t.text :details
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
