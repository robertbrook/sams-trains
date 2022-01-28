Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  

  root 'home#index'
  
  get 'reviews' => 'review#index', as: :review_list
  get 'reviews/:review' => 'review#show', as: :review_show
  
  get 'models' => 'model#index', as: :model_list
  
  get 'manufacturers' => 'manufacturer#index', as: :manufacturer_list
  
  get 'scales' => 'scale#index', as: :scale_list
  
  get 'classes' => 'class#index', as: :class_list
  
  get 'operators' => 'operator#index', as: :operator_list
  
  get 'liveries' => 'livery#index', as: :livery_list
  
  get 'detail_scores' => 'detail_score#index', as: :detail_score_list
  
  get 'performance_scores' => 'performance_score#index', as: :performance_score_list
  
  get 'mechanism_scores' => 'mechanism_score#index', as: :mechanism_score_list
  
  get 'quality_scores' => 'quality_score#index', as: :quality_score_list
  
  get 'value_scores' => 'value_score#index', as: :value_score_list
end
