# frozen_string_literal: true

RSpec.describe 'Categories', type: :request do
  # Populate test data
  # Using let! to make sure the data is populated and cached for this block before it is called
  let!(:categories) { create_list(:category, 5) }
  let!(:category_id) { categories.last.id }

  # Test for GET /categories
  describe 'GET /categories' do
    # make HTTP get request before each example
    before { get '/api/v1/categories' }
    it 'returns all categories' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test for POST /category
  describe 'POST /category' do
    # Use let as we need valid_name only for one of the context
    let(:valid_name) { { name: 'Judicial Obligations' } }
    context 'when the request is valid' do
      before { post '/api/v1/categories', params: valid_name }
      it 'creates a new category' do
        expect(json['name']).to eq('Judicial Obligations')
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/categories', params: { name: '' } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a validation error message' do
        expect(response.body)
          .to include('is too short (minimum is 3 characters)')
      end
    end
  end

  # Test for DELETE /category/:id
  describe 'DELETE /categories/:id' do
    before { delete "/api/v1/categories/#{category_id}" }
    it 'returns status code 204' do
      # Enforcing this delete to be a valid/successful request by using before above, hence 204
      expect(response).to have_http_status(204)
    end
  end
end
