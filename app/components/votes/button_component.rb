# frozen_string_literal: true

class Votes::ButtonComponent < ApplicationComponent
  def initialize(votable:, url:)
    @votable = votable
    @url = url
  end
end
