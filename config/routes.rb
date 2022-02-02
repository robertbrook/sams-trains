Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  

  root 'home#index', as: :home
  
  get 'reviews' => 'review#grid', as: :review_grid
  get 'reviews/list' => 'review#index', as: :review_list
  get 'reviews/:review' => 'review#show', as: :review_show
  
  get 'models' => 'model#index', as: :model_list
  get 'models/:model' => 'model#show', as: :model_show
  
  get 'manufacturers' => 'manufacturer#index', as: :manufacturer_list
  get 'manufacturers/:manufacturer' => 'manufacturer#show', as: :manufacturer_show
  
  get 'scales' => 'scale#index', as: :scale_list
  get 'scales/:scale' => 'scale#show', as: :scale_show
  
  get 'classes' => 'class#index', as: :class_list
  get 'classes/:class' => 'class#show', as: :class_show
  
  get 'operators' => 'operator#index', as: :operator_list
  get 'operators/:operator' => 'operator#show', as: :operator_show
  
  get 'operators/:operator/liveries' => 'operator_livery#index', as: :operator_livery_list
  
  get 'operators/:operator/models' => 'operator_model#index', as: :operator_model_list
  
  get 'liveries' => 'livery#index', as: :livery_list
  get 'liveries/:livery' => 'livery#show', as: :livery_show
  
  get 'detail-scores' => 'detail_score#index', as: :detail_score_list
  get 'detail-scores/:detail_score' => 'detail_score#show', as: :detail_score_show
  
  get 'performance-scores' => 'performance_score#index', as: :performance_score_list
  get 'performance-scores/:performance_score' => 'performance_score#show', as: :performance_score_show
  
  get 'power-scores' => 'power_score#index', as: :power_score_list
  get 'power-scores/:power_score' => 'power_score#show', as: :power_score_show
  
  get 'mechanism-scores' => 'mechanism_score#index', as: :mechanism_score_list
  get 'mechanism-scores/:mechanism_score' => 'mechanism_score#show', as: :mechanism_score_show
  
  get 'quality-scores' => 'quality_score#index', as: :quality_score_list
  get 'quality-scores/:quality_score' => 'quality_score#show', as: :quality_score_show
  
  get 'value-scores' => 'value_score#index', as: :value_score_list
  get 'value-scores/:value_score' => 'value_score#show', as: :value_score_show
end
