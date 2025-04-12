# frozen_string_literal: true

class Shared::Forms::SubmitComponent < ApplicationComponent
  def initialize(**options)
    @submit_text = options[:submit_text]
    @icon_name = options[:icon_name] || 'icons/white_spinner.svg'
    @submit_options = options[:submit_options] || {
      type: 'submit',
      class: 'text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800 inline-flex items-center',
      data: { form_target: 'submitButton' }
    }
    @icon_options = options[:icon_options] || {
      class: 'animate-spin h-4 w-4 text-white hidden',
      data: { form_target: 'spinner' }
    }
  end
end
