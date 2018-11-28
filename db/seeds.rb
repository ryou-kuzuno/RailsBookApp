# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# user情報
user1 = User.create(:nicename => "葛野一号", :password => 5509 , :mail =>4444444)
user2 = User.create(:nicename => "田中一号", :password => 'root' , :mail =>'tanaka@tanaka.com')

book_titles = ['銀河鉄道の夜', '風の又三郎', 'ポラーノの広場', 'グスコーブドリの伝記', '注文の多い料理店']
book_titles.each do |title|
  book = Bookstore.new(:title => title, :author => '宮沢賢治', :user_id => user2.id)
  book.impressions = [
    Impression.new(:story => 'ストーリテスト1', :impressions => '感想テスト1', :user_id => user1.id),
    Impression.new(:story => 'ストーリテスト2', :impressions => '感想テスト2', :user_id => user2.id)
  ]

  book.save
end
