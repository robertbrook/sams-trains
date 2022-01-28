class OperatorLiveryController < ApplicationController
  
  def index
    operator = params[:operator]
    @operator = Operator.find( operator )
  end
end
