class PerformanceScoreController < ApplicationController
  
  def index
    @performance_scores = PerformanceScore.find_by_sql(
      "
        SELECT ps.*, SUM(reviews.review_count) as review_count
        FROM performance_scores ps
        LEFT JOIN (
          SELECT r.performance_score_id AS performance_score_id, COUNT( r.* ) as review_count
          FROM reviews r
          GROUP BY r.performance_score_id
        ) reviews
        on reviews.performance_score_id = ps.id
        GROUP BY ps.id
        ORDER by ps.score
      "
    )
  end
  
  def show
    performance_score = params[:performance_score]
    @performance_score = PerformanceScore.find( performance_score )
  end
end