class CreateCrewshifts < ActiveRecord::Migration[5.2]
  def change
    create_table :crewshifts do |t|
      t.integer :user_id
      t.date :full_date
      t.integer :already

      t.timestamps
    end
  end
end
