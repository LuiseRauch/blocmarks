require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }

  it { should have_many(:bookmarks) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(1) }

end
