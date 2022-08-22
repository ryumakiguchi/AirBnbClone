class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :check_in
      t.date :check_out
      t.boolean :payment_status, default: false
      t.string :confirmation_status, default: "pending"
      t.references :flat, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
