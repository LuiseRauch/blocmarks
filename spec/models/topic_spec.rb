require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }

  it { should have_many(:bookmarks) }
end
