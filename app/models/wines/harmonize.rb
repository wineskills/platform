class Wines::Harmonize < ApplicationRecord
  has_and_belongs_to_many :wines, foreign_key: "wines_harmonize_id"
end
