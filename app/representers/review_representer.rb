# frozen_string_literal: true

class ReviewRepresenter
  def initialize(review)
    @review = review
  end

  def as_json
    {
      id: review.id,
      title: review.title,
      comment: review.comment,
      book: review.book_id,
      date_added: review.created_at
    }
  end

  private

  attr_reader :review
end
