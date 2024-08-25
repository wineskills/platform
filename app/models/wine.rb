class Wine < ApplicationRecord
  extend Pagy::Searchkick

  searchkick

  enum :kind,
       {
         red: "red",
         sparkling: "sparkling",
         dessert_port: "dessert_port",
         dessert: "dessert",
         rose: "rose",
         white: "white",
       },
       suffix: true

  enum :body,
       {
         very_light: "very_light",
         light: "light",
         medium: "medium",
         full: "full",
         very_full: "very_full",
       },
       suffix: true

  enum :acidity, { low: "low", medium: "medium", high: "high" }, suffix: true

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

  scope :search_import,
        -> { includes(:region, :winery, :elaborate, :grapes, :harmonizes) }

  validates :dataset_id,
            :name,
            :alcohol_by_volume,
            :acidity,
            :country_code,
            :vintages,
            :kind,
            :body,
            presence: true

  validates :country_code, inclusion: { in: ISO3166::Country.codes }
  validates :alcohol_by_volume, inclusion: { in: 0.0..1.0 }

  def search_data
    {
      name: name,
      kind: kind,
      body: body,
      region_name: region.name,
      winery_name: winery.name,
      country_name: country.iso_short_name,
      elaborate_name: elaborate.name,
      grapes_names: grapes.pluck(:name).join(" "),
      harmonizes_names: harmonizes.pluck(:name).join(" "),
    }
  end

  def country
    ISO3166::Country.new(self.country_code)
  end
end
