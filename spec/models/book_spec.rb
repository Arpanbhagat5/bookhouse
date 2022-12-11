require 'rails_helper'

# used some of the matchers from here: https://github.com/thoughtbot/shoulda-matchers#activemodel-matchers
RSpec.describe Book, type: :model do
  # Association test
  it { should belong_to(:category) }
  # Association test
  it { should have_many(:reviews) }
  # Validation tests
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:price) }
  it {
    should validate_length_of(:title)
    .is_at_least(3)
  }
  it {
    should validate_numericality_of(:price)
    .is_greater_than(0)
  }
end
