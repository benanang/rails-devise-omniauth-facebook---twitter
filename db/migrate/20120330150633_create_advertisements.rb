class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :item
      t.string :content

      t.timestamps
    end
  end
end
