require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/users' do # rubocop:todo Metrics/BlockLength
    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json', 'application/xml'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[username email password password_confirmation]
      }
      response '201', 'user created' do
        let(:user) do
          { username: 'test', email: 'test@example.com', password: '123456aa', password_confirmation: '123456aa' }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { username: 'test' } }
        run_test!
      end
    end

    get('shows a list of users') do
      tags 'Users' do
        produces 'application/json', 'application/xml'
        response '200', 'user found' do
          schema type: :object,
                 properties: {
                   data: {
                     type: :array,
                     items: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         username: { type: :string },
                         email: { type: :string }
                       }
                     }
                   }
                 },
                 required: ['data']
          run_test!
        end
      end
    end

    path '/users/{username}' do # rubocop:todo Metrics/BlockLength
      get 'Retrieves a user' do
        tags 'Users'
        produces 'application/json', 'application/xml'
        parameter name: :username, in: :path, type: :string
        response '200', 'user found' do
          schema type: :object,
                 properties: {
                   data: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       username: { type: :string },
                       email: { type: :string }
                     }
                   }
                 },
                 required: ['data']
          let(:username) do
            User.create(username: 'test', email: 'mail1@mail.com', password: '123456aa',
                        password_confirmation: '123456aa').username
          end
          run_test!
        end
      end
      delete 'Deletes a user' do
        tags 'Users'
        produces 'application/json', 'application/xml'
        parameter name: :username, in: :path, type: :string
        response '200', 'user deleted' do
          let(:username) do
            User.create(username: 'test', email: 'mail1@mail.com', password: '123456aa',
                        password_confirmation: '123456aa').username
          end
          run_test!
        end
      end
      patch 'Updates a user' do
        tags 'Users'
        consumes 'application/json', 'application/xml'
        parameter name: :username, in: :path, type: :string
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            username: { type: :string },
            email: { type: :string },
            password: { type: :string },
            password_confirmation: { type: :string }
          },
          required: %w[username email password password_confirmation]
        }
        response '200', 'user updated' do
          let(:username) do
            User.create(username: 'test', email: 'mail1@mail.com', password: '123456aa',
                        password_confirmation: '123456aa').username
          end
          let(:user) do
            { username: 'test', email: 'mail1@mail.com', password: '123456aa', password_confirmation: '123456aa' }
          end
          run_test!
        end
      end
    end
  end
end
