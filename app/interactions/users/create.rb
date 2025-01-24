class Users::Create < ActiveInteraction::Base
  hash :params

  def execute
    return unless params['name']
    return unless params['patronymic']
    return unless params['email']
    return unless params['age']
    return unless params['nationality']
    return unless params['country']
    return unless params['gender']

    return if User.where(email: params['email']).exists?
    return if params['age'] <= 0 || params['age'] > 90
    return if params['gender'] != 'male' && params['gender'] != 'female'

    user_full_name = "#{params['surname']} #{params['name']} #{params['patronymic']}"
    user_params = params.except(:interests)
    user = User.create(user_params.merge(user_full_name: user_full_name))

    Interest.where(name: params['interests']).each do |interest|
      user.interests << interest
    end

    user_skills = []
    params['skills'].split(',').each do |skill_name|
      skill = Skil.find_by(name: skill_name)
      user_skills << skill if skill
    end
    user.skills << user_skills
    user.save
  end
end
