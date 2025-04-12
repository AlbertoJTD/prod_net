# frozen_string_literal: true

class Shared::ErrorListComponent < ApplicationComponent
  def initialize(record:)
    @record = record
  end
end
