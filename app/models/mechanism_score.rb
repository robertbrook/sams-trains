class MechanismScore < ApplicationRecord
  
  def reviews
    @reviews = Review
      .joins( :model ).joins( :manufacturer, :scale, :operator, :locomotive_class )
      .select( 'reviews.published_on, reviews.score, models.id, scales.name as scale_name, manufacturers.name as manufacturer_name, operators.name as operator_name, locomotive_classes.name as locomotive_class_name' )
      .where( "reviews.mechanism_score_id = #{self.id}" )
      .order( 'reviews.published_on desc' )
    end
end
