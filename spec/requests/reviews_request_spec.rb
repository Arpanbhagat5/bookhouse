# frozen_string_literal: true

RSpec.describe 'Reviews', type: :request do
  # Populate test data
  # Using let! to make sure the data is populated and cached for this block before it is called
  let!(:book) { create(:book) }
  let!(:user) { create(:user) }

  let!(:book_id) { book.id }
  let!(:user_id) {user.id}

  let!(:reviews) { create_list(:review, 5, book_id:) }
  let!(:review_id) { reviews.first.id }

  describe 'GET /books/id/reviews/id' do
    # make HTTP get request before each example
    before { get "/api/v1/books/#{book_id}/reviews/#{review_id}" }

    it 'returns single review' do
      expect(json).not_to be_empty
      expect(json['id']).to eq(review_id)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /books/id/reviews' do
    # make HTTP get request before each example
    before { get "/api/v1/books/#{book_id}/reviews" }

    it 'returns all reviews' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /books/id/reviews' do
    # Making sure the referenced attribute exists
    let(:valid_attributes) do
      { title: 'Good book', comment: 'I like it for its humor.', book_id:, user_id: user_id }
    end
    context 'when request attributes are valid' do
      before { post "/api/v1/books/#{book_id}/reviews", params: valid_attributes }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/v1/books/#{book_id}/reviews", params: { invalid_param: 'random_val' } }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a failure message' do
        # This works as model defined attributes are missing from parama list
        expect(response.body).to include("can't be blank")
      end
    end
  end

  describe 'PUT /reviews/:id' do
    let(:valid_attributes) do
      { id: review_id, title: 'Recommending to friends',
        comment: 'Pretty amusing stuff', book_id: }
    end
    before { put "/api/v1/books/#{book_id}/reviews/#{review_id}", params: valid_attributes }
    context 'when review exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
      it 'updates the review' do
        updated_item = Review.find(review_id)
        # We look for exact match over regex match in case of valid update
        expect(updated_item.title).to match('Recommending to friends')
      end
    end
    context 'when the review does not exist' do
      let(:review_id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to include("Couldn't find Review with 'id'=0")
      end
    end
  end

  describe 'DELETE /books/id/reviews/:id' do
    before { delete "/api/v1/books/#{book_id}/reviews/#{review_id}" }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
