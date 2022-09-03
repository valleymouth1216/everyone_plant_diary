Rails.application.routes.draw do




devise_for :customers,controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
}


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  get 'admin'=>"admin/homes#top"
  get 'admin/calendar_diaries_date' =>'admin/homes#filter_by_date', as: "admin_date"

  namespace :admin do
  resources:customers,only:[:edit,:show,:index,:update] do
   resources :diary_books,only:[:index]
   end
  resources :diary_books,only:[:show,:update] do
   resources :diary_dates,only:[:show,:update,:index]
  end
  end


  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root 'homes#top'
    get 'diary_books/diaries' =>"diary_dates#index"
    resources :diary_books  do
     resources :diary_dates,only:[:edit,:show,:destroy,:update,:new,:create,]
    end
    get 'about'=>"homes#about"
    get 'customers/my_page' => 'customers#my_page', as: 'my_page'
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    put 'customers/information' => 'customers#update'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    get 'calendar_diaries' => 'calendar_diaries#index'
    get 'calendar_diaries_date' =>'calendar_diaries#filter_by_date', as: "date"
    resources :customers,only:[:index,:show] do
     resources:customer_diary_books,only:[:show,:index] do
      resources :diary_comments, only: [:create,:destroy]
      end
    end


    #get 'calendar_diaries/:id' =>"calendar_diaries#show"
    #get 'calendar_diaries/:year/:month/:day' =>"calendar_diaries#show"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html








end
