class ReviewController < ApplicationController
  
  def index
    @reviews = Review
      .joins( :model ).joins( :manufacturer, :scale, :operator, :locomotive_class )
      .select( 'reviews.published_on, models.id, scales.name as scale_name, manufacturers.name as manufacturer_name, operators.name as operator_name, locomotive_classes.name as locomotive_class_name' )
      .order( 'reviews.published_on desc' )
  end
  
  def show
    review = params[:review]
    @review = Review
      .joins( :model, :detail_score, :performance_score, :haulage_capability, :mechanism_score, :quality_score, :value_score, :manufacturer, :scale, :operator, :livery, :locomotive_class )
      .select( 'reviews.published_on, reviews.score, reviews.youtube_url, models.id, scales.name as scale_name,  manufacturers.id as manufacturer_id, manufacturers.name as manufacturer_name, operators.name as operator_name, liveries.name as livery_name, locomotive_classes.name as locomotive_class_name, detail_scores.score as inline_detail_score, performance_scores.score as inline_performance_score, haulage_capabilities.number_of_coaches as number_of_coaches, mechanism_scores.score as inline_mechanism_score, quality_scores.score as inline_quality_score, value_scores.score as inline_value_score' )
      .where( "reviews.id = #{review}" )
      .first
  end
end
