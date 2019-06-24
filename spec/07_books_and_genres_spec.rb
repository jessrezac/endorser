require "spec_helper"

RSpec.describe "Associations — Books and Genres:" do
  let(:book) { Book.new({title: "The Great Gatsby"}) }
  let(:genre) { Genre.new("philosophy") }

  context "Genre" do
    describe "#initialize" do
      it "creates a 'books' property set to an empty array (genre has many books)" do
        expect(genre.instance_variable_defined?(:@books)).to be(true)
        expect(genre.instance_variable_get(:@books)).to eq([])
      end
    end

    describe "#books" do
      it "returns the genre's 'books' collection (genre has many books)" do
        expect(genre.books).to eq([])

        genre.books << book

        expect(genre.books).to include(book)
      end
    end
  end

  context "Book" do
    describe "#initialize" do
      it "can be invoked with an optional third argument, a Genre object to be assigned to the book's 'genre' property (book belongs to genre)" do
        author = Author.new({name: "F. Scott Fitzgerald"})
        book_with_artist_and_genre = Book.new({title: "The Great Gatsby", author: author, genre: genre})

        expect(book_with_artist_and_genre.instance_variable_defined?(:@genre)).to be(true)
        expect(book_with_artist_and_genre.instance_variable_get(:@genre)).to be(genre)
      end
    end

    describe "#genre" do
      it "returns the genre of the book (book belongs to genre)" do
        book.instance_variable_set(:@genre, genre)

        expect(book.genre).to be(genre)
      end
    end

    describe "#genre=" do
      it "assigns a genre to the book (book belongs to genre)" do
        book.genre = genre

        expect(book.genre).to be(genre)
      end

      it "adds the book to the genre's collection of books (genre has many books)" do
        book.genre = genre

        expect(genre.books).to include(book)
      end

      it "does not add the book to the genre's collection of books if it already exists therein" do
        2.times { book.genre = genre }

        expect(genre.books).to include(book)
        expect(genre.books.size).to be(1)
      end
    end

    describe "#initialize" do
      it "invokes #genre= instead of simply assigning to a @genre instance variable to ensure that associations are created upon initialization" do
        author = Author.new({name: "F. Scott Fitzgerald"})

        expect_any_instance_of(Book).to receive(:genre=).with(genre)
        Book.new({title: "The Great Gatsby", author: author, genre: genre})
      end
    end
  end
end