class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :s3_key, :index => true
      t.string :name
      t.references :user, :index => true, :foreign_key => true
    end
  end
end
