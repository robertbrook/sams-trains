class DetailScoreController < ApplicationController
  
  def index
    @detail_scores = DetailScore.all.order( 'score' )
  end
end
