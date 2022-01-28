class Model < ApplicationRecord
  
  belongs_to :scale
  belongs_to :operator
  belongs_to :manufacturer
  belongs_to :livery
  belongs_to :locomotive_class
  has_many :reviews, -> { order 'published_on' }
  
  def title
    self.scale_name + ' ' +self.manufacturer_name + ' ' + self.operator_name + ' ' + self.locomotive_class_name
  end
end
