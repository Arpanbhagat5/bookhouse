# frozen_string_literal: true

RSpec.describe 'Books', type: :request do
  # Populate initial data for test block
  let!(:books) { create_list(:book, 10) }
  let(:book_id) { books.first.id }

  describe 'GET /books' do
    before { get '/api/v1/books' }
    it 'returns list of all books' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /books/:id' do
    before { get "/api/v1/books/#{book_id}" }
    context 'when book exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns the book item' do
        expect(json['id']).to eq(book_id)
      end
    end
    context 'when book does not exist' do
      let(:book_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Book with 'id'=0")
      end
    end
  end

  describe 'POST /books/:id' do
    # Making sure the referenced attribute exists
    let!(:book_genre) { create(:category) }
    let(:valid_attributes) do
      {
        title: 'Animal Farm',
        author: 'George Orwell',
        price: '100',
        category_id: book_genre.id
      }
    end
    context 'when request attributes are valid' do
      before do
        post '/api/v1/books',
             params: valid_attributes
      end
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when an invalid request' do
      before do
        post '/api/v1/books',
             params: { invalid_param: 'random_val' }
      end
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a failure message' do
        # This works as model defined attributes are missing from parama list
        expect(response.body).to include("can't be blank")
      end
    end
  end

  describe 'PUT /books/:id' do
    let(:valid_attributes) { { title: 'Sultan of Swings' } }
    before do
      put "/api/v1/books/#{book_id}",
          params: valid_attributes
    end
    context 'when book exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
      it 'updates the book' do
        updated_item = Book.find(book_id)
        # We look for exact match over regex match in case of valid update
        expect(updated_item.title).to match('Sultan of Swings')
      end
    end
    context 'when the book does not exist' do
      # Since ids start with 1 be default, 0 will error out
      let(:book_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Book with 'id'=0")
      end
    end
  end

  describe 'DELETE /books/:id' do
    before { delete "/api/v1/books/#{book_id}" }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
