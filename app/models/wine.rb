class Wine < ApplicationRecord
  enum :kind,
       {
         red: "red",
         sparkling: "sparkling",
         dessert_port: "dessert_port",
         dessert: "dessert",
         rose: "rose",
         white: "white",
       },
       _prefix: true

  enum :body,
       {
         very_light: "very_light",
         light: "light",
         medium: "medium",
         full: "full",
         very_full: "very_full",
       },
       _prefix: true

  belongs_to :elaborate, class_name: "Wines::Elaborate"
  belongs_to :region, class_name: "Wines::Region"
  belongs_to :winery, class_name: "Wines::Winery"

  has_and_belongs_to_many :grapes,
                          class_name: "Wines::Grape",
                          association_foreign_key: "wines_grape_id"
  has_and_belongs_to_many :harmonizes,
                          class_name: "Wines::Harmonize",
                          association_foreign_key: "wines_harmonize_id"

  has_one_attached :picture

  validates :dataset_id,
            :name,
            :alcohol_by_volume,
            :acidity,
            :country_code,
            :vintages,
            :kind,
            :body,
            presence: true

  def country
    ISO3166::Country.new(self.country_code)
  end
end
