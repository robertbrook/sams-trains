class Review < ApplicationRecord
  
  belongs_to :model
  belongs_to :haulage_capability
  belongs_to :detail_score
  belongs_to :performance_score
  belongs_to :mechanism_score
  belongs_to :quality_score
  belongs_to :value_score
end
