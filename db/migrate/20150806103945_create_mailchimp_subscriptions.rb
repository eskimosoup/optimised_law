class CreateMailchimpSubscriptions < ActiveRecord::Migration
  def change
    create_table :mailchimp_subscriptions do |t|
      t.string :forename, null: false
      t.string :surname, null: false
      t.string :email, null: false
      t.string :mailchimp_list_name

      t.timestamps null: false
    end
  end
end
