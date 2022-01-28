class ReviewController < ApplicationController
  
  def index
    @reviews = Review
      .joins( :model ).joins( :manufacturer, :scale, :operator, :locomotive_class )
      .select( 'reviews.published_on, models.id, scales.name as scale_name, manufacturers.name as manufacturer_name, operators.name as operator_name, locomotive_classes.name as locomotive_class_name' )
      .order( 'reviews.published_on desc' )
  end
end
