Rails.application.routes.draw do









  namespace :admin do
  resources:customers,only:[:edit,:show,:index,:update]
  resources :diary_books,only:[:edit,:show,:update]do
  resources :diaries,only:[:edit,:show,:update,:index,:destroy]
  end
  end


  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root 'homes#top'
    get 'my_diary' =>"my_diaries#my_diary"
    resources :diary_books do
    resources :diaries
  end
    get 'about'=>"homes#about"
    get 'customers/my_page' => 'customers#my_page', as: 'my_page'
    resources :customers,only:[:index,:show]
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    put 'customers/information' => 'customers#update'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    get 'calendar_diaries' => 'calendar_diaries#index'
    get 'calendar_diaries_date' =>'calendar_diaries#filter_by_date', as: "date"

    #get 'calendar_diaries/:id' =>"calendar_diaries#show"
    #get 'calendar_diaries/:year/:month/:day' =>"calendar_diaries#show"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

devise_for :customers,controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
}




devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

end
