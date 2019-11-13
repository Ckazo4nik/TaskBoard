class Project < ApplicationRecord
  validates :title, :color, presence: true
  has_many :tasks, dependent: :destroy
end
