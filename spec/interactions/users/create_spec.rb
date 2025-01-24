require 'rails_helper'

RSpec.describe Users::Create do
  let!(:interest) { create(:interest) }
  let!(:skill) { create(:skill) }

  context 'with valid attributes' do
    subject do
      described_class.run(
        attributes_for(:user).merge(
          interests: [interest.name],
          skills: [skill.name]
        )
      )
    end

    it 'creates a new user' do
      expect { subject }.to change { User.count }.by(1)
    end

    it 'associates interests with the user' do
      subject
      expect(User.last.interests).to include(interest)
    end

    it 'associates skills with the user' do
      subject
      expect(User.last.skills).to include(skill)
    end
  end

  context 'with invalid attributes' do
    subject do
      described_class.run(
        attributes_for(:user, name: nil).merge(
          interests: [interest.name],
          skills: [skill.name]
        )
      )
    end

    it 'does not create a new user' do
      expect { subject }.not_to change { User.count }
    end

    it 'adds an error for missing name' do
      subject
      expect(subject.errors.full_messages).to include("Name is required")
    end
  end

  context 'when email already exists' do
    let!(:existing_user) { create(:user, email: "inga@gmail.com") }

    subject do
      described_class.run(
        attributes_for(:user, email: existing_user.email).merge(
          interests: [interest.name],
          skills: [skill.name]
        )
      )
    end

    it 'does not create a new user' do
      expect { subject }.not_to change { User.count }
    end

    it 'adds an error for already existing email' do
      subject
      expect(subject.errors.full_messages).to include("Email has already been taken")
    end
  end
end
