FactoryBot.define do
  factory :wines_region, class: "Wines::Region" do
    sequence(:dataset_id, 1)

    name { "Bordeaux" }
  end
end
