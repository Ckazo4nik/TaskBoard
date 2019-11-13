# frozen_string_literal: true

class Project < ApplicationRecord
  before_destroy :check_fresh_tasks
  has_many :tasks, dependent: :destroy
  validates :title, :color, presence: true

  def check_fresh_tasks
    if tasks.fresh.any?
      throw :abort
    end
  end
end
