# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :category
  has_many :reviews

  validates :title, presence: true, length: { minimum: 3 }
  validates :author, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
