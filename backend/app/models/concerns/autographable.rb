module Autographable
  extend ActiveSupport::Concern

  def apply_elvis(intstrument_name)
    "#{intstrument_name} - signed by elvis"
  end
end