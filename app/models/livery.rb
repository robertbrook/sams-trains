class Livery < ApplicationRecord
  
  belongs_to :operator, optional: true
end
