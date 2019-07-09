require "spec_helper"

RSpec.describe "Scraper" do
  let(:scraper) { Scraper.new("https://player.fm/series/the-ezra-klein-show") }

  describe "#fetch_episodes" do
    it "instantiates some episodes" do
      expect(Episode.all).not_to be_empty
    end
  end

  describe "#write_books" do
    it "instantiates some books" do
        expect(Book.all).not_to be_empty
    end
  end
end
