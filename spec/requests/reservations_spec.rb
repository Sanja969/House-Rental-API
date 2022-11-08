require 'swagger_helper'

RSpec.describe 'Reservations API', type: :request do
  path '/reservations' do # rubocop:todo Metrics/BlockLength
    get 'Retrieves a list of reservations' do
      tags 'Reservations'
      produces 'application/json', 'application/xml'
      response '200', 'reservations found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       date: { type: :string },
                       end_date: { type: :string },
                       user_id: { type: :integer },
                       house_id: { type: :integer },
                       status: { type: :string }
                     }
                   }
                 }
               },
               required: ['data']
        run_test!
      end
    end
    post 'Creates a reservation' do
      tags 'Reservations'
      consumes 'application/json', 'application/xml'
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          date: { type: :string },
          end_date: { type: :string },
          house_id: { type: :integer },
          user_id: { type: :integer },
          status: { type: :string }
        },
        required: %w[start_date end_date house_id user_id status]
      }
      response '201', 'reservation created' do
        let(:user) do
          { username: 'test', email: 'mail1@mail.com', password: '123456aa', password_confirmation: '123456aa',
            role: 'admin' }
        end
        let(:house) do
          { name: 'test', description: 'test', price: 100, city: 'test', adress: 'test', available: true,
            user_id: user.id }
        end
        let(:reservation) do
          { start_date: '2021-01-01', end_date: '2021-01-02', house_id: house.id, user_id: user.id,
            status: 'pending' }
        end
        run_test!
      end
    end
  end
  path '/reservations/{id}' do # rubocop:todo Metrics/BlockLength
    get 'Retrieves a reservation' do
      tags 'Reservations'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      response '200', 'reservation found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     date: { type: :string },
                     end_date: { type: :string },
                     user_id: { type: :integer },
                     house_id: { type: :integer },
                     status: { type: :string }
                   }
                 }
               },
               required: ['data']
        run_test!
      end
    end
    put 'Updates a reservation' do # rubocop:todo Metrics/BlockLength
      tags 'Reservations'
      consumes 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      parameter name: :reservation, in: :body, schema: {
        type: :object,
        properties: {
          date: { type: :string },
          end_date: { type: :string },
          house_id: { type: :integer },
          user_id: { type: :integer },
          status: { type: :string }
        },
        required: %w[start_date end_date house_id user_id status]
      }
      response '200', 'reservation updated' do
        let(:user) do
          { username: 'test', email: 'mail1@mail.com', password: '123456aa', password_confirmation: '123456aa',
            role: 'admin' }
        end
        let(:house) do
          { name: 'test', description: 'test', price: 100, city: 'test', adress: 'test', available: true,
            user_id: user.id }
        end
        let(:reservation) do
          { start_date: '2021-01-01', end_date: '2021-01-02', house_id: house.id, user_id: user.id,
            status: 'pending' }
        end
        run_test!
      end
      response '404', 'reservation not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
    delete 'Deletes a reservation' do
      tags 'Reservations'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string
      response '204', 'reservation deleted' do
        let(:user) do
          { username: 'test', email: 'mail1@mail.com', password: '123456aa', password_confirmation: '123456aa',
            role: 'admin' }
        end
        let(:house) do
          { name: 'test', description: 'test', price: 100, city: 'test', adress: 'test', available: true,
            user_id: user.id }
        end
        let(:reservation) do
          { start_date: '2021-01-01', end_date: '2021-01-02', house_id: house.id, user_id: user.id,
            status: 'pending' }
        end
        run_test!
      end
    end
  end
end
