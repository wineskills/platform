FactoryBot.define do
  factory :wines_winery, class: "Wines::Winery" do
    sequence(:dataset_id, 1)

    name { "Château de la Rivière" }
    website_link { "http://www.chateaudelariviere.fr" }
  end
end
