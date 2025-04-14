# frozen_string_literal: true

class Shared::ModalComponent < ApplicationComponent
  renders_one :header_section
  renders_one :errors_section
  renders_one :body_section
  renders_one :footer_section

  def initialize(**options)
    @title = options[:title]
    @data_modal = options[:data_modal] || { controller: 'shared--modal', shared__modal_target: 'modal', action: 'turbo:frame-load->shared--modal#open turbo:submit-end->shared--modal#hideModal' }
  end
end
