class Timerpost < ApplicationRecord
  belongs_to :user
  default_scope->{order(created_at: :desc)}
  validates :user_id, presence: true
  validates :hour, presence:true, length:{maximum: 2}, numericality: {greater_than_or_equal_to: 0, less_than: 60}
  validates :minutes, presence:true, length:{maximum: 2}, numericality: {greater_than_or_equal_to: 0, less_than: 60}
  validates :second, presence:true, length:{maximum: 2}, numericality: {greater_than_or_equal_to: 0, less_than: 60}
  validates :memo, length:{maximum: 140}
end
