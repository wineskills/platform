FactoryBot.define do
  factory :wine do
    sequence(:dataset_id, 1)

    name { Faker::Beer.name }
    alcohol_by_volume { rand(0.1..0.5) }
    country_code { "FR" }
    vintages { rand(5..20).times.map { rand(1950..2020) } }
    kind { Wine.kinds.keys.sample }
    body { Wine.bodies.keys.sample }
    acidity { Wine.acidities.keys.sample }

    association :elaborate, factory: :wines_elaborate
    association :region, factory: :wines_region
    association :winery, factory: :wines_winery
  end
end
