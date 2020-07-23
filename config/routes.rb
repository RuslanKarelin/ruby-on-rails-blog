Rails.application.routes.draw do

  use_doorkeeper

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }, path_names: {sign_in: 'login', sign_out: 'logout'}

  root to: "index#show", page_alias: 'home', as: 'home'

  namespace :admin do
    get '', to: "index#index", as: 'home_admin'
    resources :categories, :posts, :pages, :users, :widgets, :widget_positions, :roles, :tags
    resources :comments, except: [:create]
  end

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
      end
    end
  end

  resources :comments, only: [:destroy]

  resources :profiles, only: [:show, :update]

  post 'comments/add', to: 'comments#add'
  post 'blog/add_post', to: 'posts#add_post', as: 'add_post'

  get 'blog/:category_alias', to: 'categories#show', as: 'category'
  get 'blog/:category_alias/:post_alias', to: 'posts#show', as: 'post'
  get 'search', to: 'search#show', as: 'search'
  get 'tags/:tag', to: 'tags#show', as: 'tags'
  get 'get-pagination', to: 'application#get_pagination', as: 'pagination'
  get ':page_alias', to: 'pages#show', as: 'page'
end
