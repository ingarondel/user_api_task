require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'POST #create' do
    let!(:interest) { create(:interest) }
    let!(:skill) { create(:skill) }

    context 'with valid attributes' do
      let(:valid_attributes) do
        attributes_for(:user).merge(
          interests: [interest.name],
          skills: [skill.name]
        )
      end

      it 'creates a new user and returns status 201' do
        expect {
          post '/users', params: { user: valid_attributes }, as: :json
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(201)
        json_response = JSON.parse(response.body)
        expect(json_response['user']['name']).to eq(valid_attributes[:name])
      end

      it 'associates interests with the user' do
        post '/users', params: { user: valid_attributes }, as: :json
        expect(User.last.interests).to include(interest)
      end

      it 'associates skills with the user' do
        post '/users', params: { user: valid_attributes }, as: :json
        expect(User.last.skills).to include(skill)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        attributes_for(:user, name: nil).merge(
          interests: [interest.name],
          skills: [skill.name]
        )
      end

      it 'does not create a new user and returns status 422' do
        expect {
          post '/users', params: { user: invalid_attributes }, as: :json
        }.not_to change(User, :count)

        expect(response).to have_http_status(422) 
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Name is required")
      end

      it 'logs the error messages' do
        expect(Rails.logger).to receive(:error).with(array_including("Name is required"))
        post '/users', params: { user: invalid_attributes }, as: :json
      end
    end

    context 'when email already exists' do
      let!(:existing_user) { create(:user, email: "inga@gmail.com") }
      let(:duplicate_email_attributes) do
        attributes_for(:user, email: existing_user.email).merge(
          interests: [interest.name],
          skills: [skill.name]
        )
      end

      it 'does not create a new user and returns status 422' do
        expect {
          post '/users', params: { user: duplicate_email_attributes }, as: :json
        }.not_to change(User, :count)

        expect(response).to have_http_status(422) 
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Email has already been taken")
      end

      it 'logs the error messages' do
        expect(Rails.logger).to receive(:error).with(array_including("Email has already been taken"))
        post '/users', params: { user: duplicate_email_attributes }, as: :json
      end
    end
  end
end
