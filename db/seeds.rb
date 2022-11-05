# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


tags = [
         { name: "野菜" },
         { name: "果物" },
         { name: "花" },
         { name: "木" },
         { name: "その他" }
       ]

tags.each do |tag|
  Tag.find_or_create_by(tag)
end



Admin.find_or_create_by!(email: "everyone_plant_diary_admin@a") do |admin|
  admin.email = "everyone_plant_diary_admin@a"
  admin.password = "123456"
end



customers = [
             { email: "aa@a", name: "令和", password: "123456" },
             { email: "okei@test.com", name: "okei", password: "123456" },
             { email: "tarou@test.com", name: "太郎", password: "123456" }
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

first_tag_id = Tag.first.id                       # 野菜
second_tag_id = Tag.limit(1).offset(1).first.id   # 果物
third_tag_id = Tag.limit(1).offset(2).first.id    # 花
fourth_tag_id = Tag.limit(1).offset(3).first.id   # 木
last_tag_id = Tag.last.id                         # その他

first_customer_id = Customer.first.id                       # 令和
second_customer_id = Customer.limit(1).offset(1).first.id   # okei
last_customer_id = Customer.last.id                         # 太郎

diary_books = DiaryBook.create!(
  [
   { customer_id: second_customer_id, title: "米", status: "true", tag_ids: [first_tag_id, last_tag_id] },
   { customer_id: second_customer_id, title: "枝豆", status: "true", tag_ids: [first_tag_id] },
   { customer_id: second_customer_id, title: "桜", tag_ids: [third_tag_id] },
   { customer_id: first_customer_id, title: "桜", status: "true", tag_ids: [tag_ids.sample] },
   { customer_id: first_customer_id, title: "ひまわり", tag_ids: [tag_ids.sample] }
  ]
)

first_diary_book_id = DiaryBook.first.id
second_diary_book_id = DiaryBook.limit(1).offset(1).first.id
third_diary_book_id = DiaryBook.limit(1).offset(2).first.id
last_diary_book_id = DiaryBook.last.id

diary_dates = DiaryDate.create!(
  [
   { diary_book_id: first_diary_book_id, start_time: "2022-9-09 15:00:00", temperature: "20", body: "稲刈りの為、おじいちゃんの家に夜帰ってきました。" },
   { diary_book_id: first_diary_book_id, start_time: "2022-9-10 15:00:00", temperature: "20", status: "true",
    body: "2つの田んぼの稲を刈りしました。とは言ってもほとんどはコンバインが刈ってくれました。一つ目の田んぼは猪に田んぼを荒らされた(猪の大運動会)です。
           稲がかなり倒れていましたなので手で稲を刈りました......。途中マムシがいたそうです。(ちょっと見たかった).
           なんとか一つ目が終わり、二つの田んぼ(ドロドロの田んぼで強い風の影響でこちらも稲がたおれていました。)です。
           昼の2時ごろから雨が降り、余計に田んぼがドロドロしてきました。途中でやみましたが、勘弁して欲しいです。
           途中コンバインも使っていましたが、壊れました。(稲が水分を多く含んでいたため故障したようです。)その為ほとんど手刈りになりました．．．。
           何度も何度もドロに足がつかまり、倒れている稲を刈っていくそして泥まみれになっていく。。。。.今週は筋肉痛確定です....." },
   { diary_book_id: first_diary_book_id, start_time: "2022-9-11 15:00:00", temperature: "20", status: "true",
   body: "稲刈り二日目です。コンバインが壊れておかげではぜ干しすることになりました。もちろんいねも刈りましたがこれが今日のメインです。
          はぜ干しする為に稲をしばっていきますが、終わらない。。。。(どんだけあるんだ)。午前の10時からやって終わったのが午後16時でした。(縛るひもがなくなったのと今日お家に帰るため)
          途中で稲が多くてはぜ干しの棒がドミノ倒しのように倒れました。ずっと晴れていたので少し日焼けしました。
          お昼ご飯は外でみんなで食べました。いつもとは違う新鮮な感じで美味しかったです。" },
   { diary_book_id: first_diary_book_id, start_time: "2022-5-15 15:00:00", temperature: "19", body: "田植えをしたそうです。去年よりお米がとれますように", status: "true" },
   { diary_book_id: first_diary_book_id, start_time: "2022-9-12 15:00:00", body: "昨日、稲刈りしたから、足と腰が筋肉痛．．．。動けない．．．。今日は会社お休みしました。早く治りますように", status: "true" },
   { diary_book_id: first_diary_book_id, start_time: "2022-9-13 15:00:00", body: "今日も筋肉痛です。昨日と変わらない。だけど会社に行って仕事しました。", status: "true" },
   { diary_book_id: first_diary_book_id, start_time: "2022-9-14 15:00:00", body: "昨日と変わらない。早く治って欲しい" },
   { diary_book_id: first_diary_book_id, start_time: "2022-9-17 15:00:00", body: "やったと筋肉痛から解放されました。健康でいられるって幸せだと感じるぐらいひどかったです。", status: "true" },
   { diary_book_id: first_diary_book_id, start_time: "2022-9-19 15:00:00", body: "台風のおかげではぜ干しが倒れました。悲しい", status: "true" },
   { diary_book_id: first_diary_book_id, start_time: "2022-10-1 15:00:00", body: "はぜ干ししたものを脱穀したそうです。(私は家でのんびり)", status: "true" },
   { diary_book_id: second_diary_book_id, start_time: "2022-5-15 15:00:00", temperature: "15", body: "田舎で今日と植えようとしたら苗の葉っぱかじられて茎しかない！！どういうこと？？？", status: "true" },
   { diary_book_id: second_diary_book_id, start_time: "2022-5-21 15:00:00", temperature: "15", body: "今回は苗を家の中においたからかじられずに済んだ誰に食べれているの？？", status: "true" },
   { diary_book_id: second_diary_book_id, start_time: "2022-10-01 15:00:00", temperature: "15", body: "またかじれてる．．．柵でなんとかならないかな", status: "true" },
   { diary_book_id: second_diary_book_id, start_time: "2022-10-08 15:00:00", temperature: "15", body: "あんなことがあったけどなんとか収穫出来ました。", status: "true" },
   { diary_book_id: last_diary_book_id, start_time: "2022-04-08 15:00:00", temperature: "15", body: "桜を見に来ました。", status: "true" },
   { diary_book_id: last_diary_book_id, start_time: "2022-04-09 15:00:00", temperature: "15", body: "今日も桜を見に来ました。" },
   { diary_book_id: second_diary_book_id, start_time: "2022-10-09 15:00:00", temperature: "15", body: "またかじれてるどんだけかじれば気が済むの" }
  ]
)

second_diary_book_id = DiaryDate.limit(1).offset(1).first.id # 2022-9-09
third_diary_book_id = DiaryDate.limit(1).offset(2).first.id
last_diary_book_id = DiaryDate.last.id

DiaryDate.find(2).diary_images.attach(io: File.open("#{Rails.root}/db/seed_images/inekari/20220910_092503.jpg"), filename: "20220910_092503.jpg")
DiaryDate.find(2).diary_images.attach(io: File.open("#{Rails.root}/db/seed_images/inekari/20220910_101153.jpg"), filename: "20220910_101153.jpg")
DiaryDate.find(2).diary_images.attach(io: File.open("#{Rails.root}/db/seed_images/inekari/20220910_101155.jpg"), filename: "20220910_101155.jpg")
DiaryDate.find(3).diary_images.attach(io: File.open("#{Rails.root}/db/seed_images/inekari/20220911_162826.jpg"), filename: "20220911_162826.jpg")
DiaryDate.find(3).diary_images.attach(io: File.open("#{Rails.root}/db/seed_images/inekari/20220911_162846.jpg"), filename: "20220911_162846.jpg")
DiaryDate.find(3).diary_images.attach(io: File.open("#{Rails.root}/db/seed_images/inekari/20220911_164428.jpg"), filename: "20220911_164428.jpg")
DiaryDate.find(9).diary_images.attach(io: File.open("#{Rails.root}/db/seed_images/inekari/20220919_112100.jpg"), filename: "20220919_112100.jpg")
DiaryDate.find(10).diary_images.attach(io: File.open("#{Rails.root}/db/seed_images/inekari/20221001_120400.jpg"), filename: "20221001_120400.jpg")
DiaryDate.find(10).diary_images.attach(io: File.open("#{Rails.root}/db/seed_images/inekari/20221001_131500.jpg"), filename: "20221001_131500.jpg")



DiaryComment.create!(
  [
   { customer_id: first_customer_id, diary_date_id: third_diary_book_id, comment: "お疲れ様です。" },
   { customer_id: last_customer_id, diary_date_id: third_diary_book_id, comment: "お疲れ様です。大変でしたね。" },
   { customer_id: last_customer_id, diary_date_id: third_diary_book_id, comment: "今日ですべて終わったのですか？" },
   { customer_id: second_customer_id, diary_date_id: third_diary_book_id, comment: "稲刈りは終わりました。まだ脱穀とかいろんな作業がのこっています。" },
   { customer_id: last_customer_id, diary_date_id: third_diary_book_id, comment: "ひとまず、お疲れ様です。" },
  ]
)
Favorite.create!(
  [
   { customer_id: last_customer_id, diary_date_id: first_diary_book_id },
   { customer_id: second_customer_id, diary_date_id: second_diary_book_id },
   { customer_id: last_customer_id, diary_date_id: first_diary_book_id }
  ]
)
