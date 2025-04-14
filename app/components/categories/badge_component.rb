# frozen_string_literal: true

class Categories::BadgeComponent < ApplicationComponent
  def initialize(name:, **options)
    @name = name
    @style = options[:style] || 'absolute top-0 right-0 mt-4 mr-4 text-xs text-white px-2 py-1 font-semibold bg-gray-600 bg-opacity-100 rounded-md uppercase'
    @style = badge_style(options[:color]) if options[:color].present?
  end

  def badge_style(color)
    badge_colors = {
      'indigo' => 'bg-indigo-100 text-indigo-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-indigo-900 dark:text-indigo-300',
      'purple' => 'bg-purple-100 text-purple-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-purple-900 dark:text-purple-300',
      'pink' => 'bg-pink-100 text-pink-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-pink-900 dark:text-pink-300',
      'blue' => 'bg-blue-100 text-blue-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-blue-900 dark:text-blue-300',
      'gray' => 'bg-gray-100 text-gray-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-gray-700 dark:text-gray-300',
      'red' => 'bg-red-100 text-red-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-red-900 dark:text-red-300',
      'green' => 'bg-green-100 text-green-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-green-900 dark:text-green-300',
      'yellow' => 'bg-yellow-100 text-yellow-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-yellow-900 dark:text-yellow-300',
      'orange' => 'bg-orange-100 text-orange-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-orange-900 dark:text-orange-300',
      'brown' => 'bg-brown-100 text-brown-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-brown-900 dark:text-brown-300',
      'lime' => 'bg-lime-100 text-lime-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-lime-900 dark:text-lime-300',
      'teal' => 'bg-teal-100 text-teal-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-teal-900 dark:text-teal-300',
      'cyan' => 'bg-cyan-100 text-cyan-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-cyan-900 dark:text-cyan-300',
      'fuchsia' => 'bg-fuchsia-100 text-fuchsia-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-fuchsia-900 dark:text-fuchsia-300',
      'violet' => 'bg-violet-100 text-violet-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded-sm dark:bg-violet-900 dark:text-violet-300',
    }

    badge_colors[color] || badge_colors['blue']
  end
end
