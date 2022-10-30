# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


tags = [
         { name: '野菜' },
         { name: '果物' },
         { name: '花'},
         { name: '木'},
         { name: 'その他'}
       ]

tags.each do |tag|
  Tag.find_or_create_by(tag)
end



Admin.find_or_create_by!(email: "everyone_plant_diary_admin@a") do |admin|
  admin.email = "everyone_plant_diary_admin@a"
  admin.password = "123456"
end



customers = [
             {email: 'aa@a', name: '令和', password: '123456'},
             {email: 'hanako@test.com', name: '花子', password: '123456'},
             {email: 'tarou@test.com', name: '太郎', password: '123456'}
            ]

customers.each do |customer|
  customer_data = Customer.find_by(email: customer[:email])
  if customer_data.nil?
    Customer.create(
      email: customer[:email],
      password: customer[:password],
      name: customer[:name],
    )
  end
end


customer_ids = Customer.ids
tag_ids = Tag.ids


diary_books = DiaryBook.create!(
  [
   {customer_id: customer_ids.sample, title: '米',status: "true", tag_ids: [tag_ids.sample]},
   {customer_id: customer_ids.sample, title: '枝豆',tag_ids: [tag_ids.sample]},
   {customer_id: customer_ids.sample, title: '桜',tag_ids: [tag_ids.sample]},
   {customer_id: customer_ids.sample, title: '桜' ,status: "true",tag_ids: [tag_ids.sample]},
   {customer_id: customer_ids.sample, title: 'ひまわり' ,tag_ids: [tag_ids.sample]}
  ]
)

first_diary_book_id = DiaryBook.first.id
second_diary_book_id =DiaryBook.limit(1).offset(1).first.id
last_diary_book_id =DiaryBook.last.id

 DiaryDate.create!(
  [
   {diary_book_id: first_diary_book_id, start_time: '2022-9-13 15:00:00',temperature: '20',body: "稲を刈りしました。猪に田んぼを荒らされた(猪の大運動会のおかげで)ので手刈りました。途中コンバインも使っていましたが、壊れました。今週は筋肉痛確定です.....",status: "true" },
   {diary_book_id: first_diary_book_id, start_time: '2022-9-14 15:00:00',temperature: '20',body: "稲刈り二日目です。お昼ご飯は外でみんなで食べました。いつもとは違う新鮮な感じで美味しかったです。",status: "true"},
   {diary_book_id: first_diary_book_id, start_time: '2022-5-15 15:00:00',temperature: '19',body: "田植えをしました。去年よりお米がとれますように",status: "true"},
   {diary_book_id: first_diary_book_id, start_time: '2022-9-16 15:00:00',body: "昨日、稲刈りしたから全身筋肉痛．．．足動かせない早く治りますように",status: "true"},
   {diary_book_id: first_diary_book_id, start_time: '2022-9-20 15:00:00',body: "やったと筋肉痛から解放されました。健康でいられるって幸せだと感じるぐらいひどかったです。",status: "true"},
   {diary_book_id: first_diary_book_id, start_time: '2022-9-15 15:00:00',temperature: '19',body: "お米をはぜぼししました。もう来年はやりたくないです。"},
   {diary_book_id: second_diary_book_id, start_time: '2022-5-15 15:00:00',temperature: '15',body: "田舎で今日と植えようとしたら苗の葉っぱかじられて茎しかない！！どういうこと？？？",status: "true"},
   {diary_book_id: second_diary_book_id, start_time: '2022-5-21 15:00:00',temperature: '15',body: "今回は苗を家の中においたからかじられずに済んだ誰に食べれているの？？",status: "true"},
   {diary_book_id: second_diary_book_id, start_time: '2022-10-01 15:00:00',temperature: '15',body: "またかじれてる．．．柵でなんとかならないかな",status: "true"},
   {diary_book_id: second_diary_book_id, start_time: '2022-10-08 15:00:00',temperature: '15',body: "あんなことがあったけどなんとか収穫出来ました。",status: "true"},
   {diary_book_id: last_diary_book_id, start_time: '2022-04-08 15:00:00',temperature: '15',body: "桜を見に来ました。",status: "true"},
   {diary_book_id: last_diary_book_id, start_time: '2022-04-09 15:00:00',temperature: '15',body: "今日も桜を見に来ました。"},
   {diary_book_id: second_diary_book_id, start_time: '2022-10-09 15:00:00',temperature: '15',body: "またかじれてるどんだけかじれば気が済むの"}
  ]
)

DiaryDate.first.diary_images.attach(io: File.open("#{Rails.root}/db/fixtures/20220910_092503.jpg"), filename:"20220910_092503.jpg")
DiaryDate.first.diary_images.attach(io: File.open("#{Rails.root}/db/fixtures/20220910_092503.jpg"), filename:"20220910_092503.jpg")

first_customer_id = Customer.first.id
second_customer_id = Customer.limit(1).offset(1).first.id
last_customer_id = Customer.last.id

DiaryComment.create!(
  [
   {customer_id: second_customer_id, diary_date_id: second_diary_book_id,comment: "お疲れ様です。"},
   {customer_id: last_customer_id, diary_date_id: second_diary_book_id,comment: "お疲れ様です。大変でしたね。"},
   {customer_id: last_customer_id, diary_date_id: second_diary_book_id,comment: "今日ですべて終わったのですか？"},
   {customer_id: first_customer_id, diary_date_id: second_diary_book_id,comment: "稲刈りは終わりました。"},
   {customer_id: second_customer_id, diary_date_id: '5',comment: "本当にお疲れ様です。"}
  ]
)
Favorite.create!(
  [
   {customer_id: last_customer_id, diary_date_id: first_diary_book_id},
   {customer_id: second_customer_id, diary_date_id: second_diary_book_id},
   {customer_id: last_customer_id, diary_date_id: first_diary_book_id}
  ]
)