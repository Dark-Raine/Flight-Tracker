class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :ArrivalTime
      t.string :DepartTime
      t.integer :Price
      t.integer :Duration
      t.string :OriginPlace
      t.string :DestinationPlace

      t.timestamps
    end
  end
end
