module Loggable
  extend ActiveSupport::Concern

  def log_params(params)
    "+++> controller params: #{params}"
  end
end