# frozen_string_literal: true

module ApplicationHelper
  def get_priority_color(task)
    return 'white' if task.low?

    task.high? ? 'red' : 'orange'
  end
end
