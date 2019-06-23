require "spec_helper"

RSpec.describe "PodcastBookClub" do
  it "has a version number" do
    expect(PodcastBookClub::VERSION).not_to be nil
  end

  it "has Episodes" do
    episode = Episode.new({title:"Test Episode"})
    expect(episode).to be_truthy
  end

  it "has Books" do
    book = Book.new({title:"Test Book"})
    expect(book).to be_truthy
  end

  it "has Genres" do
    genre = Genre.new({name:"Genre"})
    expect(genre).to be_truthy
  end

  it "has Authors" do
    author = Author.new({name:"Author Name"})
    expect(author).to be_truthy
  end

end

