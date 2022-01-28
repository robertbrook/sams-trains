class ModelController < ApplicationController
  
  def index
    @models = Model
      .joins( :manufacturer, :scale, :operator, :locomotive_class )
      .select( 'models.id, scales.name as scale_name, manufacturers.name as manufacturer_name, operators.name as operator_name, locomotive_classes.name as locomotive_class_name' )
      .order( 'scale_name, manufacturer_name, operator_name, locomotive_class_name' )
  end
  
  def show
    model = params[:model]
    @model = Model
      .joins( :manufacturer, :scale, :operator, :livery, :locomotive_class )
      .select( 'models.id, scales.id as scale_id, scales.name as scale_name, manufacturers.id as manufacturer_id, manufacturers.name as manufacturer_name, operators.id as operator_id, operators.name as operator_name, liveries.name as livery_name, locomotive_classes.id as locomotive_class_id, locomotive_classes.name as locomotive_class_name' )
      .where( "models.id = #{model}" )
      .first
  end
end
