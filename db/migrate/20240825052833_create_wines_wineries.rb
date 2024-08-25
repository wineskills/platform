class CreateWinesWineries < ActiveRecord::Migration[7.2]
  def change
    create_table :wines_wineries, id: :uuid do |t|
      t.integer :dataset_id
      t.string :name
      t.string :website_link

      t.timestamps
    end
  end
end
