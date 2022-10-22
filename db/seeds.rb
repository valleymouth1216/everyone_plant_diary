# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Tag.create([
    { name: '野菜' },
    { name: '果物' },
    { name: '花'},
    { name: '木'},
    { name: 'その他'}
    ])

Admin.create!(
  email: "everyone_plant_diary_admin@a",
  password: "123456"
)

customers = Customer.create!(
  [
    {email: 'aa@a', name: '令和', password: '123456'},
    {email: 'hanako@test.com', name: '花子', password: '123456'},
    {email: 'tarou@test.com', name: '太郎', password: '123456'}
  ]
)

diary_books = DiaryBook.create!(
  [
   {customer_id: '1', title: '米',status: "true", tag_ids: [1]},
   {customer_id: '1', title: '枝豆',tag_ids: [1]},
   {customer_id: '1', title: '桜',tag_ids: [3]},
   {customer_id: '2', title: '桜' ,status: "true",tag_ids: [3]},
   {customer_id: '2', title: 'ひまわり' ,tag_ids: [3]}
  ]
)

diarydates = DiaryDate.create!(
  [
   {diary_book_id: '1', start_time: '2022-9-13 15:00:00',temperature: '20',body: "稲を刈りしました。猪に田んぼを荒らされた(猪の大運動会のおかげで)ので手刈りました。途中コンバインも使っていましたが、壊れました。今週は筋肉痛確定です.....",status: "true"},
   {diary_book_id: '1', start_time: '2022-9-14 15:00:00',temperature: '20',body: "稲刈り二日目です。お昼ご飯は外でみんなで食べました。いつもとは違う新鮮な感じで美味しかったです。",status: "true"},
   {diary_book_id: '1', start_time: '2022-5-15 15:00:00',temperature: '19',body: "田植えをしました。去年よりお米がとれますように",status: "true"},
   {diary_book_id: '1', start_time: '2022-9-16 15:00:00',body: "昨日、稲刈りしたから全身筋肉痛．．．足動かせない早く治りますように",status: "true"},
   {diary_book_id: '1', start_time: '2022-9-20 15:00:00',body: "やったと筋肉痛から解放されました。健康でいられるって幸せだと感じるぐらいひどかったです。",status: "true"},
   {diary_book_id: '1', start_time: '2022-9-15 15:00:00',temperature: '19',body: "お米をはぜぼししました。もう来年はやりたくないです。"},
   {diary_book_id: '2', start_time: '2022-5-15 15:00:00',temperature: '15',body: "田舎で今日と植えようとしたら苗の葉っぱかじられて茎しかない！！どういうこと？？？",status: "true"},
   {diary_book_id: '2', start_time: '2022-5-21 15:00:00',temperature: '15',body: "今回は苗を家の中においたからかじられずに済んだ誰に食べれているの？？",status: "true"},
   {diary_book_id: '2', start_time: '2022-10-01 15:00:00',temperature: '15',body: "またかじれてる．．．柵でなんとかならないかな",status: "true"},
   {diary_book_id: '2', start_time: '2022-10-08 15:00:00',temperature: '15',body: "あんなことがあったけどなんとか収穫出来ました。",status: "true"},
   {diary_book_id: '4', start_time: '2022-04-08 15:00:00',temperature: '15',body: "桜を見に来ました。",status: "true"},
   {diary_book_id: '4', start_time: '2022-04-09 15:00:00',temperature: '15',body: "今日も桜を見に来ました。"},
   {diary_book_id: '2', start_time: '2022-10-09 15:00:00',temperature: '15',body: "またかじれてるどんだけかじれば気が済むの"}
  ]
)

diary_comments = DiaryComment.create!(
  [
   {customer_id: '2', diary_date_id: '2',comment: "お疲れ様です。"},
   {customer_id: '3', diary_date_id: '2',comment: "お疲れ様です。大変でしたね。"},
   {customer_id: '3', diary_date_id: '2',comment: "今日ですべて終わったのですか？"},
   {customer_id: '1', diary_date_id: '2',comment: "稲刈りは終わりました。"},
   {customer_id: '2', diary_date_id: '5',comment: "本当にお疲れ様です。"}
  ]
)
favorites = Favorite.create!(
  [
   {customer_id: '2', diary_date_id: '1'},
   {customer_id: '2', diary_date_id: '2'},
   {customer_id: '3', diary_date_id: '1'}
  ]
)