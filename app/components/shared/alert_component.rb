# frozen_string_literal: true

class Shared::AlertComponent < ApplicationComponent
  def initialize(message:, type:)
    @message = message
    @type = type
    @background_color = background_color
    @icon_background_color = icon_background_color
  end

  def background_color
    case @type
    when 'success'
      'text-green-800 bg-green-50 dark:bg-gray-800 dark:text-green-400'
    when 'info'
      'text-blue-800 bg-blue-50 dark:bg-gray-800 dark:text-blue-400'
    when 'warning'
      'text-yellow-800 bg-yellow-50 dark:bg-gray-800 dark:text-yellow-400'
    when 'error'
      'text-red-800 bg-red-50 dark:bg-gray-800 dark:text-red-400'
    end
  end

  def icon_background_color
    case @type
    when 'success'
      'bg-green-50 text-green-500 focus:ring-green-400 p-1.5 hover:bg-green-200 dark:text-green-400'
    when 'info'
      'bg-blue-50 text-blue-500 focus:ring-blue-400 p-1.5 hover:bg-blue-200 dark:text-blue-400'
    when 'warning'
      'bg-yellow-50 text-yellow-500 focus:ring-yellow-400 p-1.5 hover:bg-yellow-200 dark:text-yellow-400'
    when 'error'
      'bg-red-50 text-red-500 focus:ring-red-400 p-1.5 hover:bg-red-200 dark:text-red-400'
    end
  end
end
