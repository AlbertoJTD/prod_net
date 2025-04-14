# frozen_string_literal: true

class Comments::ItemComponent < ApplicationComponent
  def initialize(comment:)
    @comment = comment
  end
end
