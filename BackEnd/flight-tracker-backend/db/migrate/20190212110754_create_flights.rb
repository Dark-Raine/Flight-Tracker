class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :booking_url
      t.date :OutboundDate
      t.date :InboundDate
      t.integer :Price
      t.integer :Duration
      t.string :OriginPlace
      t.string :DestinationPlace
      
      t.timestamps
    end
  end
end
