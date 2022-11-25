# frozen_string_literal: true

RSpec.describe 'Root', type: :request do
  before do
    get '/'
  end

  it 'response is successful' do
    expect(last_response).to be_successful
  end

  it 'response contains hello' do
    expect(last_response.body).to eq('Hello from Hanami')
  end
end
