class User < ApplicationRecord
  has_many :timerposts, dependent: :destroy

  attr_accessor :remember_token

  before_save{email.downcase!}
  # before_save{self.email = email.downcase}

  validates :name, presence: true, length:{maximum:50}
  VALID_EMAIL_REGIX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length:{maximum:225},
    format: {with: VALID_EMAIL_REGIX},
    uniqueness: true
    # uniqueness: {case_sensitive: false}

    has_secure_password
    validates :password, presence: true, length:{minimum: 6},allow_nil: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶させる
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # ==による直接比較はできないため「is_password?」である
  end

  def forget
    update_attribute(:remember_digest,nil)
  end

  def feed
    Timerpost.where('user_id = ?',id)
  end

  private



end
