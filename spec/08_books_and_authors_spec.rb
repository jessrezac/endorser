require "spec_helper"

RSpec.describe "Associations — Books and Authors:" do
  let(:book) { Book.new({title: "The Great Gatsby"}) }
  let(:book_two) { Book.new({title: "Tender Is The Night"})}
  let(:author) { Author.new({name: "F. Scott Fitzgerald"}) }
  let(:author_two) { Author.new({name: "Ernest Hemingway"}) }


  context "Author" do
    describe "#initialize" do
      it "creates a 'books' property set to an empty array (author has many books)" do
        expect(author.instance_variable_defined?(:@books)).to be(true)
        expect(author.instance_variable_get(:@books)).to eq([])
      end
    end

    describe "#books" do
      it "returns the author's 'books' collection (author has many books)" do
        expect(author.books).to eq([])

        author.books << book

        expect(author.books).to include(book)
      end
    end
  end

  context "Book" do
    describe "#initialize" do
      it "can be invoked with a Author object to be assigned to the book's 'author' property (book belongs to author)" do
        book_with_author = Book.new({title: "The Great Gatsby", author: author})

        expect(book_with_author.instance_variable_defined?(:@author)).to be(true)
        expect(book_with_author.instance_variable_get(:@author)).to include(author)
      end

      it "invokes #author= instead of simply assigning to an @author instance variable to ensure that associations are created upon initialization" do
        expect_any_instance_of(Book).to receive(:author=).with(author)
        Book.new({title: "The Great Gatsby", author: author})
      end

    end

    describe "#author" do
      it "returns the author of the book (book belongs to author)" do
        book.instance_variable_set(:@author, author)

        expect(book.author).to be(author)
      end
    end

    describe "#author=" do
      it "assigns an author to the book (book belongs to author)" do
        book.author = author

        expect(book.author).to include(author)
      end

      it "adds the book to the author's collection of books (author has many books)" do
        book.author = author

        expect(author.books).to include(book)
      end

      it "does not add the book to the author's collection of books if it already exists therein" do
        2.times { book.author = author }

        expect(author.books).to include(book)
        expect(author.books.size).to be(1)
      end

      it "accepts multiple authors" do
        book = Book.new({title: "An Imaginary Expatriate Reader", author: [author, author_two]})

        expect(book.author.size).to be(2)
      end

        end
    
    end
end