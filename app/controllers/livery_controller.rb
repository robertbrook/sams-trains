class LiveryController < ApplicationController
  
  def index
    @liveries = Livery.all.order( 'name' )
  end
  
  def show
    livery = params[:livery]
    @livery = Livery.find_by_sql(
      "
        SELECT l.*, operator.operator_id AS operator_id, operator.operator_name AS operator_name
        FROM liveries l
        LEFT JOIN (
          SELECT o.id AS operator_id, o.name AS operator_name
          FROM operators o
        ) operator
        ON operator.operator_id = l.operator_id
        WHERE l.id = #{livery}
      "
    ).first
  end
end
