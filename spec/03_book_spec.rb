require "spec_helper"

RSpec.describe "Book" do
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
  
    describe "@@all" do
  
      it "is initialized as an empty array" do
        all = Book.class_variable_get(:@@all)
  
        expect(all).to match_array([])
      end
  
    end
  
    describe ".all" do
      it "returns the class variable @@all" do
        expect(Book.all).to match_array([])
  
        Book.class_variable_set(:@@all, [book])
  
        expect(Book.all).to match_array([book])
      end
    end
  
    describe ".destroy_all" do
      it "resets the @@all class variable to an empty array" do
        Book.class_variable_set(:@@all, [book])
  
        Book.destroy_all
  
        expect(Book.all).to match_array([])
      end
    end
  
    describe "#save" do
      it "adds the Book instance to the @@all class variable" do
        book.save
  
        expect(Book.all).to include(book)
      end
    end
  
    describe ".create" do
      it "initializes, saves, and returns the book" do
        created_book = Book.create({title: "The Girl With the Dragon Tattoo"})
  
        expect(Book.all).to include(created_book)
      end
    end
  
  end