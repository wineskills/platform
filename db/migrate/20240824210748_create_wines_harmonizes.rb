class CreateWinesHarmonizes < ActiveRecord::Migration[7.2]
  def change
    create_table :wines_harmonizes, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    create_join_table :wines,
                      :wines_harmonizes,
                      column_options: {
                        type: :uuid,
                      } do |t|
      t.index :wine_id
      t.index :wines_harmonize_id
    end
  end
end
