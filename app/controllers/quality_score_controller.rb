class QualityScoreController < ApplicationController
  
  def index
    @quality_scores = QualityScore.find_by_sql(
      "
        SELECT qs.*, SUM(reviews.review_count) as review_count
        FROM quality_scores qs
        LEFT JOIN (
          SELECT r.quality_score_id AS quality_score_id, COUNT( r.* ) as review_count
          FROM reviews r
          GROUP BY r.quality_score_id
        ) reviews
        on reviews.quality_score_id = qs.id
        GROUP BY qs.id
        ORDER by qs.score
      "
    )
  end
  
  def show
    quality_score = params[:quality_score]
    @quality_score = QualityScore.find( quality_score )
  end
end
