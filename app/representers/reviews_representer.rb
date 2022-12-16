# frozen_string_literal: true

class ReviewsRepresenter
  def initialize(reviews)
    @reviews = reviews
  end

  def as_json
    reviews.map do |review|
      {
        id: review.id,
        title: review.title,
        comment: review.comment,
        book: review.book_id,
        date_added: review.created_at
      }
    end
  end

  private

  attr_reader :reviews
end
