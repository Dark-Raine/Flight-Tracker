class CreateUserflights < ActiveRecord::Migration[5.2]
  def change
    create_table :userflights do |t|
      t.integer :user_id
      t.integer :flight_id

      t.timestamps
    end
  end
end
