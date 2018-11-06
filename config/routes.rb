Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get ':book_id/create'  => "comments#create"
  delete ':book_id/destroy' => "comments#destroy"
  
  post "likes/:book_id/create"  => "likes#create"
  post "likes/:book_id/destroy" => "likes#destroy"
  
  post "update/:id" => "users#update"#ユーザーの変更を反映
  get "users/:id/edit" => "users#edit" #ユーザー編集画面
  get "users/:id/likes"     => "users#likes"#お気に入り画面
  get "users/:id"    => "users#show"#ユーザーの詳細画面
  post "users/create" => "users#create"#ユーザー作成
  get "signup"        => "users#new"#ユーザー登録画面
  post "login"        => "users#login"#ログインする
  post "logout"       => "users#logout"#ログアウトする
  get "/"         => "users#login_form"#ログイン画面

  post "create"        => "books#create"#本を作るアクション
  post ":id/destroy"=> "books#destroy"#削除機能で削除する
  post ":id/update" => "books#update"#変更を反映
  get "new"           => "books#new"#新規登録画面
  get ":id/edit"    => "books#edit"#編集画面
  post "show/:id/comment" => "comment#reply"
  get "show/:id"    => "books#show"#詳細画面
  get "index"         => "books#index"


end
