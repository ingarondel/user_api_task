class Users::Create < ActiveInteraction::Base
  string :name, :patronymic, :email, :nationality, :country, :gender
  integer :age
  array :interests, default: []
  array :skills, default: []

  def execute
    user_full_name = "#{name} #{patronymic}"

    user = User.new({
      name: name,
      patronymic: patronymic,
      email: email,
      age: age,
      nationality: nationality,
      country: country,
      gender: gender,
      full_name: user_full_name
    })

    if user.save
      assign_interests(user)
      assign_skills(user)
      user
    else
      errors.merge!(user.errors)
    end
  end

  private

  def assign_interests(user)
    interests_to_add = Interest.where(name: interests)
    interests_to_add.each do |interest|
      user.interests << interest unless user.interests.include?(interest)
    end
  end

  def assign_skills(user)
    skills_to_add = Skill.where(name: skills)
    skills_to_add.each do |skill|
      user.skills << skill unless user.skills.include?(skill)
    end
  end
end
