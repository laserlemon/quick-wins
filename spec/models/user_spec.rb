require "spec_helper"

describe User do
  describe ".authenticate" do
    let!(:user) { create(:user, username: "steve", password: "secret") }

    it "returns the user corresponding to the given username and password" do
      expect(User.authenticate("steve", "secret")).to eq(user)
    end

    it "returns nil for an unknown username" do
      expect(User.authenticate("laserlemon", "secret")).to be_falsey
    end

    it "returns nil for an incorrect password" do
      expect(User.authenticate("steve", "password")).to be_falsey
    end
  end
end
