class CreateWinesGrapes < ActiveRecord::Migration[7.2]
  def change
    create_table :wines_grapes, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    create_join_table :wines,
                      :wines_grapes,
                      column_options: {
                        type: :uuid,
                      } do |t|
      t.index :wine_id
      t.index :wines_grape_id
    end
  end
end
