require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create(:topic) }

  it { should have_many(:bookmarks) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_length_of(:title).is_at_least(1) }

  describe "destroy_if_no_bookmarks" do

    it "should delete the users bookmarks if there are bookmarks of other users saved in it" do
    end
    it "should delete a topic if there are no bookmarks of other users saved in it" do
    end
  end

end
