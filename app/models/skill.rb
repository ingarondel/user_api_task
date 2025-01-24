class Skill < ApplicationRecord
  has_and_belongs_to_many :users
end

#2nd way: create the alias
#class Skil < Skill; end
