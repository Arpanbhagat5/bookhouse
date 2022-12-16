# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :book
  validates :title, presence: true, length: { minimum: 3 }
  validates :comment, presence: true, length: { minimum: 5 }
end
