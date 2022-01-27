class Model < ApplicationRecord
  
  belongs_to :scale
  belongs_to :operator
  belongs_to :manufacturer
  belongs_to :livery
  belongs_to :locomotive_class
end
