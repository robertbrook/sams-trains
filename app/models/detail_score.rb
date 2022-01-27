class DetailScore < ApplicationRecord
  
  belongs_to :review
  belongs_to :score
end
