class MechanismScoreController < ApplicationController
  
  def index
    @mechanism_scores = MechanismScore.find_by_sql(
      "
        SELECT ms.*, SUM(reviews.review_count) as review_count
        FROM mechanism_scores ms
        LEFT JOIN (
          SELECT r.mechanism_score_id AS mechanism_score_id, COUNT( r.* ) as review_count
          FROM reviews r
          GROUP BY r.mechanism_score_id
        ) reviews
        on reviews.mechanism_score_id = ms.id
        GROUP BY ms.id
        ORDER by ms.score
      "
    )
  end
  
  def show
    mechanism_score = params[:mechanism_score]
    @mechanism_score = MechanismScore.find( mechanism_score )
  end
end
