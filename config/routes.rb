Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    ':book_id/create'  => "comments#create"#投稿にコメントする
  delete ':book_id/destroy' => "comments#destroy"#投稿に対するコメントを削除する
  post   ":id/destroy"=> "books#destroy"#投稿を削除する
  # form_forがうまく表示されなかったのはimpression_idになっていなかったから
  post   "show/:impression_id/comment" => "books#reply"
  # メモ：controller名 + action + （必要に応じてid） という形式がrails標準
  # こうすることでbundle exec rails routes を打ったときに、prefixとして、likes_create という名前ができる
  post   "likes/create"  => "likes#create"
  post   "likes/:impression_id/destroy" => "likes#destroy"
  
  get    "search"  =>  "books#search" #検索結果を出力

  patch  "user/:id/update" => "users#update"#ユーザーの変更を反映
  get    "users/:id/edit" => "users#edit" #ユーザー編集画面
  get    "users/:id/likes"     => "users#likes"#お気に入り画面
  get    "users/:id"    => "users#show"#ユーザーの詳細画面
  post   "users/create" => "users#create"#ユーザー作成
  get    "signup"        => "users#new"#ユーザー登録画面
  post   "login"        => "users#login"#ログインする
  post   "logout"       => "users#logout"#ログアウトする
  get    "/"         => "users#login_form"#ログイン画面
  # railsの規約に合わせると model + actionの形にroutingもしておくのがベター
  get    "books/new"           => "books#new"#新規登録画面
  post   "books/create"        => "books#create"#本を作るアクション
  
  patch   "books/:impression_id/update" => "books#update"#変更を反映
  get    "new"           => "books#new"#新規登録画面
  get    ":impression_id/edit"    => "books#edit"#編集画面
  
  get    "show/:impression_id"    => "books#show"#詳細画面
  get    "index"         => "books#index"


end
