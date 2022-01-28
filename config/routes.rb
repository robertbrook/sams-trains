Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  

  root 'home#index'
  
  get 'reviews' => 'review#index', as: :review_list
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
  
  get 'detail_scores' => 'detail_score#index', as: :detail_score_list
  
  get 'performance_scores' => 'performance_score#index', as: :performance_score_list
  
  get 'mechanism_scores' => 'mechanism_score#index', as: :mechanism_score_list
  
  get 'quality_scores' => 'quality_score#index', as: :quality_score_list
  
  get 'value_scores' => 'value_score#index', as: :value_score_list
end
