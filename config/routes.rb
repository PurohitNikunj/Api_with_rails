Rails.application.routes.draw do
    namespace :api do
        namespace :v1 do
            resources :articles, only: [:index, :create, :destroy, :show, :update] do
                resources :comments, only: [:index, :create, :destroy, :show, :update]
            end
        end
    end
    get 'search_article', to: "api/v1/articles#search_article", :as => :search_article
    get 'search_comment', to: "api/v1/comments#search_comment", :as => :search_comment
end
