class Review < ApplicationRecord
  
  belongs_to :model
  belongs_to :haulage_capability
  belongs_to :detail_score
  belongs_to :performance_score
  belongs_to :mechanism_score
  belongs_to :quality_score
  belongs_to :value_score
  
  has_one :scale, :through => :model
  has_one :operator, :through => :model
  has_one :manufacturer, :through => :model
  has_one :livery, :through => :model
  has_one :locomotive_class, :through => :model
  
  def title
    'Review of a ' + self.scale_name + ' ' +self.manufacturer_name + ' ' + self.operator_name + ' Class ' + self.locomotive_class_name
  end
  
  def youtube_id
    self.youtube_url.split( '=' ).last
  end
end
