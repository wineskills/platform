class Wines::OneCreator
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def call
    wine = Wine.find_or_initialize_by(dataset_id: attributes[:dataset_id])
    assign_attributes(wine)
    wine.save!

    assign_picture(wine)
  end

  private

  # Assign attributes to wine
  def assign_attributes(wine)
    wine.name = attributes[:name]
    wine.alcohol_by_volume = attributes[:alcohol_by_volume]
    wine.acidity = attributes[:acidity].downcase
    wine.country_code = attributes[:country_code]
    wine.vintages = eval(attributes[:vintages])

    # Kind
    wine.kind =
      attributes[:kind].presence.try do |kind|
        I18n.transliterate(kind.downcase.gsub(%r{/}, "_"))
      end

    # Body
    wine.body =
      attributes[:body].presence.try do |body|
        body.chomp("-bodied").downcase.gsub(/\s/, "_")
      end

    # Elaborate
    wine.elaborate =
      Wines::Elaborate.find_or_initialize_by(name: attributes[:elaborate])

    # Grapes
    wine.grapes =
      eval(attributes[:grapes]).map do |name|
        Wines::Grape.find_or_initialize_by(name:)
      end

    # Harmonizes
    wine.harmonizes =
      eval(attributes[:harmonizes]).map do |name|
        Wines::Harmonize.find_or_initialize_by(name:)
      end

    # Region
    wine.region =
      Wines::Region.find_or_initialize_by(
        dataset_id: attributes[:region_dataset_id],
      ) { |winery| winery.name = attributes[:region_name] }

    # Winery
    wine.winery =
      Wines::Winery.find_or_initialize_by(
        dataset_id: attributes[:winery_dataset_id],
      ) do |winery|
        winery.name = attributes[:winery_name]
        winery.website_link = attributes[:winery_website_link]
      end
  end

  # Assign picture to wine
  def assign_picture(wine)
    picture = Rails.root.join("data", "pictures", "#{wine.dataset_id}.jpeg")
    if picture.exist?
      wine.picture.attach(io: File.open(picture), filename: picture.basename)
    end
  end
end
