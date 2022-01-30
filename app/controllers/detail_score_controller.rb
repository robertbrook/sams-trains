class DetailScoreController < ApplicationController
  
  def index
    @detail_scores = DetailScore.find_by_sql(
      "
        SELECT ds.*, SUM(reviews.review_count) as review_count
        FROM detail_scores ds
        LEFT JOIN (
          SELECT r.detail_score_id AS detail_score_id, COUNT( r.* ) as review_count
          FROM reviews r
          GROUP BY r.detail_score_id
        ) reviews
        on reviews.detail_score_id = ds.id
        GROUP BY ds.id
        ORDER by ds.score
      "
    )
  end
  
  def show
    detail_score = params[:detail_score]
    @detail_score = DetailScore.find( detail_score )
  end
end
