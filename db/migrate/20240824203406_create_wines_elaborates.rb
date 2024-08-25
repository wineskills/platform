class CreateWinesElaborates < ActiveRecord::Migration[7.2]
  def change
    create_table :wines_elaborates, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
