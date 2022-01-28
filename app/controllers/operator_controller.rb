class OperatorController < ApplicationController
  
  def index
    @operators = Operator.all.order( 'name' )
  end
  
  def show
    operator = params[:operator]
    @operator = Operator.find( operator )
  end
end
