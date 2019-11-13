class Task < ApplicationRecord
  validates :name, :to_do_until, presence: true
  validate :check_to_do_until_date
  belongs_to :project, optional: true
  enum status: %i[fresh done]
  enum priority: %i[low middle high]

  scope :filter_by_project, ->(project_id) { where(project_id: project_id) if project_id }
  scope :filter_by_date_range, ->(date_range) { where('to_do_until <= ?', date_range || Date.tomorrow) }

  def check_to_do_until_date
    if to_do_until.nil?
      errors[:to_do_until] << 'TODO date nil!'
    elsif to_do_until < Date.today
      errors[:to_do_until] << 'Check your date field, please'
    end
  end
end
