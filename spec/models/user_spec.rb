require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:age) }
  it { should validate_presence_of(:nationality) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:gender) }
  
  it { should validate_numericality_of(:age).is_greater_than(0).is_less_than_or_equal_to(90) }
  it { should validate_inclusion_of(:gender).in_array(%w[male female]) }
  it { should validate_uniqueness_of(:email) }
  
  it { should have_and_belong_to_many(:interests) }
  it { should have_and_belong_to_many(:skills) }
end
