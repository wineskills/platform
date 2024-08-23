class Wines::Grape < ApplicationRecord
  has_and_belongs_to_many :wines, foreign_key: "wines_grape_id"
end
