require "spec_helper"

RSpec.describe PodcastBookClub do
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

RSpec.describe Book do
  let(:book) { Book.new({title: "The Great Gatsby", 
    author: "F. Scott Fitzgerald", 
    synopsis: "The description of the book",
    genre: "fiction",
    episode: "An Ezra Klein Show Episode"}) }


  describe "#initialize" do

    it "accepts attributes for the book" do
      expect(book.title).to eq("The Great Gatsby")
    end

  end

  describe "#title" do

    it "retrieves the title of the book" do
      expect(book.title).to eq("The Great Gatsby")
    end

  end

  describe "#title=" do

    it "can set the title of a book" do
      book.title = "Tender Is The Night"

      book_title = book.instance_variable_get(:@title)

      expect(book_title).to eq("Tender Is The Night")
    end

  end

  describe "#search_googlebooks" do
    it "receives a string" do
      expect(false).to eq(true)
    end

    it "intantiates a book if none exists" do
      expect(false).to eq(true)
    end

    it "does not create a new book if one exists" do
      expect(false).to eq(true)
    end

  end
  
  

end