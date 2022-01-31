class ValueScoreController < ApplicationController
  
  def index
    @value_scores = ValueScore.find_by_sql(
      "
        SELECT vs.*, SUM(reviews.review_count) as review_count
        FROM value_scores vs
        LEFT JOIN (
          SELECT r.value_score_id AS value_score_id, COUNT( r.* ) as review_count
          FROM reviews r
          GROUP BY r.value_score_id
        ) reviews
        on reviews.value_score_id = vs.id
        GROUP BY vs.id
        ORDER by vs.score
      "
    )
  end
  
  def show
    value_score = params[:value_score]
    @value_score = ValueScore.find( value_score )
  end
end
