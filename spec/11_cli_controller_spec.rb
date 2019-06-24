require "spec_helper"

RSpec.describe "PodcastBookClub::CLI" do
  describe "#initialize" do

    it "creates a new Scraper object" do
      expect(Scraper).to receive(:new)

      PodcastBookClub::CLI.new
    end

  end

  describe "#call" do
    let(:podcast_book_club_controller) { PodcastBookClub::CLI.new }

    it "welcomes the user" do
      allow(podcast_book_club_controller).to receive(:gets).and_return("exit")

      expect($stdout).to receive(:puts).with("Welcome to Podcast Book Club!")
      expect($stdout).to receive(:puts).with("To list available episodes to build a library, enter 'list episodes'.")
      expect($stdout).to receive(:puts).with("To create a library from all episodes, enter 'create library'.")
      expect($stdout).to receive(:puts).with("To quit, type 'exit'.")
      expect($stdout).to receive(:puts).with("What would you like to do?")

      podcast_book_club_controller.call
    end

    it "asks the user for input" do
      allow(podcast_book_club_controller).to receive(:gets).and_return("exit")

      expect(podcast_book_club_controller).to receive(:gets)

      capture_puts { podcast_book_club_controller.call }
    end

    it "loops and asks for user input until they type in exit" do
      allow(podcast_book_club_controller).to receive(:gets).and_return("a", "b", "c", "exit")

      expect(podcast_book_club_controller).to receive(:gets).exactly(4).times

      capture_puts { podcast_book_club_controller.call }
    end
  end
end
