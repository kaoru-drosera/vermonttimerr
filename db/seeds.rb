# メインのサンプルユーザーを作る
User.create!(name:'Example User', email: 'example@railstutorial.org.com', password: 'foobar', password_confirmation: 'foobar', admin: true)

# 追加のユーザーをまとめて追加する
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

# ユーザーの一部を対象に投稿を追加する
users = User.order(:created_at).take(6)
50.times do
  hour = Faker::Number.between(from:0, to:59)
  minutes = Faker::Number.between(from:0, to:59)
  second = Faker::Number.between(from:0, to:59)
  memo = Faker::Lorem.sentence(word_count: 5)
  title = Faker::Name.name
  users.each{|user| user.timerposts.create!(hour: hour, minutes: minutes, second: second, memo: memo, title: title)}
end


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
