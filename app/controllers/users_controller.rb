class UsersController < ApplicationController
	def create
	  outcome = Users::Create.run(user_params)
	  
	  if outcome.valid?
	    render json: { user: outcome.result }, status: :created
	  else
	    Rails.logger.error(outcome.errors.full_messages) 
	    render json: { errors: outcome.errors.full_messages }, status: :unprocessable_entity
	  end
	end

  private

  def user_params
    params.require(:user).permit(
      :name, :patronymic, :email, :nationality, :country, :gender, :age,
      interests: [], skills: []
    )
  end
end
