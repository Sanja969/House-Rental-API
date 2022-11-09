require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'HOUSE RENTAL API',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://{heroku}',
          variables: {
            defaultHost: {
              default: 'x-house-book.herokuapp.com/'
            }
          }
        }
      ]
    }
  }

  config.swagger_format = :yaml
end
