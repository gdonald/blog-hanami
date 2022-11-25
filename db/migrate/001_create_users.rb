# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :users do
      primary_key :id
      column :email, String, null: false, unique: true, limit: 64
      column :p_salt, String, limit: 80
      column :p_hash, String, limit: 80
      column :fname, String, limit: 32
      column :lname, String, limit: 32
      column :last_login, String, index: true
      column :updated_at, Time, null: false
      column :created_at, Time, null: false
    end
  end
end
