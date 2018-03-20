class RobotProofController < ApplicationController
  def certify
  	name = "President Aoun"
  	@message = "#{name} is certified 100\% robot proof."
  end
end
