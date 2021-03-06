class CreateTwoFactorAuthRegistrations < ActiveRecord::Migration
  def change
    create_table :two_factor_auth_registrations do |t|
      t.references :login, polymorphic: true, null: false, index: true
      t.binary :key_handle,  null: false, limit: 65 # Defined in FIDO spec
      t.binary :public_key,  null: false, limit: 10.kilobytes
      t.binary :certificate, null: false, limit: 1.megabyte, default: ""
      t.integer :counter,    null: false, limit: 5, default: 0 # limit in bytes; no easy way to get a 32b *unsigned*
      t.timestamp :last_authenticated_at, null: false
      t.timestamps
    end
    add_index :two_factor_auth_registrations, :key_handle
    add_index :two_factor_auth_registrations, :last_authenticated_at
  end
end
