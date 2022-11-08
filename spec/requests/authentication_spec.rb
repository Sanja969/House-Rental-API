require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do
  path '/auth/login' do
    post 'Authenticates a user' do
      tags 'Authentication'
      consumes 'application/json', 'application/xml'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      response '200', 'user authenticated' do
        let(:user) do
          { username: 'test', email: 'mail1@mail.com', password: '123456aa', password_confirmation: '123456aa',
            role: 'admin' }
        end
        run_test!
      end
      response '401', 'unauthorized' do
        let(:user) { { email: 'foo', password: 'bar' } }
        run_test!
      end
    end
  end
end
