class CreateWines < ActiveRecord::Migration[7.2]
  def change
    create_enum :wine_kind, %i[red sparkling dessert_port dessert rose white]
    create_enum :wine_body, %i[very_light light medium full very_full]
    create_enum :wine_acidity, %i[low medium high]

    create_table :wines, id: :uuid do |t|
      t.integer :dataset_id
      t.string :name
      t.decimal :alcohol_by_volume, precision: 3, scale: 3
      t.string :country_code
      t.integer :vintages, array: true, default: []

      t.enum :kind, enum_type: :wine_kind, default: :red, null: false
      t.enum :body, enum_type: :wine_body, default: :very_light, null: false
      t.enum :acidity, enum_type: :wine_acidity, default: :low, null: false

      t.references :elaborate,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     to_table: :wines_elaborates,
                   }

      t.references :region,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     to_table: :wines_regions,
                   }

      t.references :winery,
                   type: :uuid,
                   null: false,
                   foreign_key: {
                     to_table: :wines_wineries,
                   }

      t.timestamps
    end
  end
end
