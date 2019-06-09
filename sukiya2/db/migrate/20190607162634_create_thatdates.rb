class CreateThatdates < ActiveRecord::Migration[5.2]
  def change
    create_table :thatdates do |t|
      t.integer :date
      t.date :expire
      t.date :full_date

      t.timestamps
    end
  end
end
