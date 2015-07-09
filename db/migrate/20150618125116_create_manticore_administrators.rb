class CreateManticoreAdministrators < ActiveRecord::Migration
  def change
    create_table "manticore_administrators", :force => true do |t|
      t.string   "username"
      t.string   "email"
      t.string   "role"
      t.string   "password_digest"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "auth_token"
      t.string   "password_reset_token"
      t.datetime "password_reset_send_at"
    end
    Manticore::Administrator.create(:email => 'admin@eskimosoup.co.uk', :username => 'eskimosoup', :password => 'mantpoipoip', :password_confirmation => 'mantpoipoip', :role => 'souper')
  end
end
