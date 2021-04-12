namespace :task_sample do
  desc "実行処理の説明"
  task :sample do
    puts "Hello World."
  end

  desc "task_sample_user_model"
  task :task_model => :environment do
    puts User.first().to_yaml # Userモデルを参照する
  end
end
