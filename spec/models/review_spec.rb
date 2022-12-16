# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  # Association test
  it { should belong_to(:book) }
  it { should belong_to(:user) }

  # Validation tests
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:comment) }
  it {
    should validate_length_of(:title)
      .is_at_least(3)
  }
  it {
    should validate_length_of(:comment)
      .is_at_least(5)
  }
end
