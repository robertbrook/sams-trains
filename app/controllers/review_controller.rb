class ReviewController < ApplicationController
  
  def index
    @reviews = Review
      .joins( :model ).joins( :manufacturer, :scale, :operator, :locomotive_class )
      .select( 'reviews.published_on, reviews.score, models.id, scales.name as scale_name, manufacturers.name as manufacturer_name, operators.name as operator_name, locomotive_classes.name as locomotive_class_name' )
      .order( 'reviews.published_on desc' )
  end
  
  def grid
    
    # We get the order parameter.
    order_parameter = params[:order]
    
    # We substitute any hyphen in the parameter string for an underscore to match the SQL.
    order_parameter.gsub!( '-', '_') if order_parameter
    
    # We check the type of order parameter.
    case order_parameter
      
      
      # When the order parameter is train set ...
      when 'train_set'
        
        # ... we set the order to be based on the reviewed as part of train set descending.
        order = 'reviews.reviewed_as_part_of_trainset desc'
        
      # When the order parameter is overall score ...
      when 'overall_score'
      
        # ... we set the order to be based on the overall score descending.
        order = 'reviews.score desc'
        
      # When the order parameter is manufacturer, scale, operator, locomotive class or livery ...
      when 'manufacturer', 'scale', 'operator', 'locomotive_class', 'livery'
        
        # ... we set the order to the value of the order parameter concatenated with '_name'.
        order = "#{order_parameter}_name"
        
      # When the order is a score of type detail, performance, mechanism, quality, value or power ...
      when 'detail_score', 'performance_score', 'mechanism_score', 'quality_score', 'value_score', 'power_score'
        
        # ... we set the order to be the value of the order parameter concatenated with '_score' ...
        # ... and order descending to show the highest score first.
        order = "#{order_parameter}_score desc"
      else
        order = 'reviews.published_on desc'
      end
    
    
    @reviews = Review
      .joins( :model, :detail_score, :performance_score, :mechanism_score, :quality_score, :value_score, :haulage_capability ).joins( :manufacturer, :scale, :operator, :locomotive_class, :livery,  )
      .select( 'reviews.*, models.id, scales.id as scale_id, scales.name as scale_name, manufacturers.id as manufacturer_id, manufacturers.name as manufacturer_name, operators.id as operator_id, operators.name as operator_name, locomotive_classes.id as locomotive_class_id, locomotive_classes.name as locomotive_class_name, liveries.id as livery_id, liveries.name as livery_name, detail_scores.id as detail_score_id, detail_scores.score as detail_score_score, performance_scores.id as performance_score_id, performance_scores.score as performance_score_score, mechanism_scores.id as mechanism_score_id, mechanism_scores.score as mechanism_score_score, quality_scores.id as quality_score_id, quality_scores.score as quality_score_score, value_scores.id as value_score_id, value_scores.score as value_score_score, haulage_capabilities.id as power_score_id, haulage_capabilities.number_of_coaches as power_score_score' )
      .order( order )
  end
  
  def show
    review = params[:review]
    @review = Review
      .joins( :model, :detail_score, :performance_score, :haulage_capability, :mechanism_score, :quality_score, :value_score, :manufacturer, :scale, :operator, :livery, :locomotive_class )
      .select( 'reviews.published_on, reviews.score, reviews.youtube_url, models.id, scales.id as scale_id, scales.name as scale_name,  manufacturers.id as manufacturer_id, manufacturers.name as manufacturer_name, operators.id as operator_id, operators.name as operator_name, liveries.id as livery_id, liveries.name as livery_name, locomotive_classes.id as locomotive_class_id, locomotive_classes.name as locomotive_class_name, detail_scores.id as detail_score_id, detail_scores.score as inline_detail_score, performance_scores.id as performance_score_id, performance_scores.score as inline_performance_score, haulage_capabilities.id as haulage_capability_id, haulage_capabilities.number_of_coaches as number_of_coaches, mechanism_scores.id as mechanism_score_id, mechanism_scores.score as inline_mechanism_score, quality_scores.id as quality_score_id, quality_scores.score as inline_quality_score, value_scores.id as value_score_id, value_scores.score as inline_value_score' )
      .where( "reviews.id = #{review}" )
      .first
  end
end
