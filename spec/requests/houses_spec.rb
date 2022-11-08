require 'swagger_helper'

RSpec.describe 'Houses API', type: :request do
    path '/houses' do
        get 'Retrieves a list of houses' do
            tags 'Houses'
            produces 'application/json', 'application/xml'
            response '200', 'houses found' do
                schema type: :object,
                properties: {
                    data: {
                        type: :array,
                        items: {
                            type: :object,
                            properties: {
                                id: { type: :integer },
                                name: { type: :string },
                                description: { type: :string },
                                price: { type: :integer },
                                city: { type: :string },
                                adress: { type: :string },
                                available: { type: :boolean }
                            }
                        }
                    }
                },
                required: [ 'data' ]
                run_test!
            end
        end
        post 'Creates a house' do
            tags 'Houses'
            consumes 'application/json', 'application/xml'
            parameter name: :house, in: :body, schema: {
                type: :object,
                properties: {
                    name: { type: :string },
                    description: { type: :string },
                    price: { type: :integer },
                    city: { type: :string },
                    adress: { type: :string },
                    available: { type: :boolean },
                    user_id: { type: :integer }
                },
                required: [ 'name', 'description', 'price', 'city', 'adress', 'available', 'user_id' ]
            }
            response '201', 'house created' do
                let(:user) { {username: 'test', email: 'mail1@mail.com', password: '123456aa', password_confirmation: '123456aa', role: 'admin'} }
                let(:house) { { name: 'test', description: 'test', price: 100, city: 'test', adress: 'test', available: true, user_id: user.id } }
                run_test!
            end
            response '422', 'invalid request' do
                let(:house) { { name: 'test' } }
                run_test!
            end
        end
    end
    path '/houses/{id}' do
        get 'Retrieves a house' do
            tags 'Houses'
            produces 'application/json', 'application/xml'
            parameter name: :id, :in => :path, :type => :string
            response '200', 'house found' do
                schema type: :object,
                properties: {
                    data: {
                        type: :object,
                        properties: {
                            id: { type: :integer },
                            name: { type: :string },
                            description: { type: :string },
                            price: { type: :integer },
                            city: { type: :string },
                            adress: { type: :string },
                            available: { type: :boolean }
                        }
                    }
                },
                required: [ 'data' ]
                run_test!
            end
            response '404', 'house not found' do
                let(:id) { 'invalid' }
                run_test!
            end
        end
        patch 'Updates a house' do
            tags 'Houses'
            consumes 'application/json', 'application/xml'
            parameter name: :id, :in => :path, :type => :string
            parameter name: :house, in: :body, schema: {
                type: :object,
                properties: {
                    name: { type: :string },
                    description: { type: :string },
                    price: { type: :integer },
                    city: { type: :string },
                    adress: { type: :string },
                    available: { type: :boolean },
                    user_id: { type: :integer }
                },
                required: [ 'name', 'description', 'price', 'city', 'adress', 'available', 'user_id' ]
            }
            response '200', 'house updated' do
                let(:user) { {username: 'test', email: 'mail1@mail.com', password: '123456aa', password_confirmation: '123456aa', role: 'admin'} }
                let(:house) { { name: 'test', description: 'test', price: 100, city: 'test', adress: 'test', available: true, user_id: user.id } }
                run_test!
            end
            response '422', 'invalid request' do
                let(:house) { { name: 'test' } }
                run_test!
            end
        end
        delete 'Deletes a house' do
            tags 'Houses'
            parameter name: :id, :in => :path, :type => :string
            response '204', 'house deleted' do
                run_test!
            end
        end
    end
end