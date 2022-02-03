class HomeController < ApplicationController
  
  def index
    @reviews = Review
      .joins( :model ).joins( :manufacturer, :scale, :operator, :locomotive_class )
      .select( 'reviews.published_on, reviews.score, models.id, scales.name as scale_name, manufacturers.name as manufacturer_name, operators.name as operator_name, locomotive_classes.name as locomotive_class_name' )
      .order( 'reviews.published_on desc' )
    render :template => 'review/index'
  end
end
