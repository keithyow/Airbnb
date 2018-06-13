class ApplicationController < ActionController::Base
  include Clearance::Controller

  def allowed?(action:, user:)
    # implement some code
  end


end
