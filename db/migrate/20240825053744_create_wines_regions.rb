class CreateWinesRegions < ActiveRecord::Migration[7.2]
  def change
    create_table :wines_regions, id: :uuid do |t|
      t.integer :dataset_id
      t.string :name

      t.timestamps
    end
  end
end
