# frozen_string_literal: true

class Shared::ModalComponent < ApplicationComponent
  renders_one :header_section
  renders_one :errors_section
  renders_one :body_section
  renders_one :footer_section

  def initialize(**options)
    @title = options[:title]
  end
end
