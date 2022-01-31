class PowerScoreController < ApplicationController
  
  def index
    @power_scores = HaulageCapability.find_by_sql(
      "
        SELECT hc.*, SUM(reviews.review_count) as review_count
        FROM haulage_capabilities hc
        LEFT JOIN (
          SELECT r.haulage_capability_id AS haulage_capability_id, COUNT( r.* ) as review_count
          FROM reviews r
          GROUP BY r.haulage_capability_id
        ) reviews
        on reviews.haulage_capability_id = hc.id
        GROUP BY hc.id
        ORDER by hc.number_of_coaches
      "
    )
  end
  
  def show
    power_score = params[:power_score]
    @power_score = HaulageCapability.find( power_score )
  end
end
