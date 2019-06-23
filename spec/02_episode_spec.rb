require "spec_helper"

RSpec.describe "Episode" do
    let(:episode) { Episode.new({title: "An episode of the ezra klein show",  
      description: "",
      date: "10/31/2019",
      link: "http://player.fm/the-ezra-klein-show"}) }
  
  
    describe "#initialize" do
  
      it "accepts attributes for the episode" do
        expect(episode.title).to eq("An episode of the ezra klein show")
      end
  
    end
  
    describe "#title" do
  
      it "retrieves the title of the episode" do
        expect(episode.title).to eq("An episode of the ezra klein show")
      end
  
    end
  
    describe "#title=" do
  
      it "can set the title of the episode" do
        episode.title = "Another episode title"
  
        episode_title = episode.instance_variable_get(:@title)
  
        expect(episode_title).to eq("Another episode title")
      end
  
    end
  
    describe "@@all" do
  
      it "is initialized as an empty array" do
        all = Episode.class_variable_get(:@@all)
  
        expect(all).to match_array([])
      end
  
    end
  
    describe ".all" do
      it "returns the class variable @@all" do
        expect(Episode.all).to match_array([])
  
        Episode.class_variable_set(:@@all, [episode])
  
        expect(Episode.all).to match_array([episode])
      end
    end
  
    describe ".destroy_all" do
      it "resets the @@all class variable to an empty array" do
        Episode.class_variable_set(:@@all, [episode])
  
        Episode.destroy_all
  
        expect(Episode.all).to match_array([])
      end
    end
  
    describe "#save" do
      it "adds the Book instance to the @@all class variable" do
        episode.save
  
        expect(Episode.all).to include(book)
      end
    end
  
    describe ".create" do
      it "initializes, saves, and returns the episode" do
        created_episode = Episode.create({title: "A created episode of the Ezra Klein Show"})
  
        expect(Episode.all).to include(created_episode)
      end
    end
  
  end