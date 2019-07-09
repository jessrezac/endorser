require "spec_helper"

RSpec.describe "Associations — Author and Genre:" do
  let(:genre) { Genre.new("fiction") }
  let(:other_genre) { Genre.new("romance") }
  let(:author) { Author.new({name: "F. Scott Fitzgerald"}) }
  let(:other_author) { Author.new({name: "Ernest Hemingway"}) }

  context "Author" do
    describe "#genres" do
      it "returns a collection of genres for all of the author's books (author has many genres through books)" do
        Book.new({title: "The Great Gatsby", author: author, genre: genre})
        Book.new({title: "Tender Is The Night", author: author, genre: other_genre})

        expect(author.genres).to include(genre)
        expect(author.genres).to include(other_genre)
        expect(author.genres.size).to be(2)
      end

      it "does not return duplicate genres if the author has more than one book of a particular genre (author has many genres through books)" do
        Book.new({title: "The Old Man and The Sea", author: other_author, genre: genre})
        Book.new({title: "For Whom The Bell Tolls", author: other_author, genre: genre})

        expect(other_author.genres).to include(genre)
        expect(other_author.genres.size).to eq(1)
      end

      it "collects genres through its books instead of maintaining its own @genres instance variable (author has many genres through books)" do
        Book.new({title: "The Great Gatsby", author: author, genre: genre})

        expect(author.instance_variable_defined?(:@genres)).to be_falsey
      end
    end
  end

  context "Genre" do
    describe "#authors" do
      it "returns a collection of authors for all of the genre's books (genre has many authors through books)" do
        Book.new({title: "The Old Man and The Sea", author: other_author, genre: genre})
        Book.new({title: "The Great Gatsby", author: author, genre: genre})

        expect(genre.authors).to include(author)
        expect(genre.authors).to include(other_author)
        expect(genre.authors.size).to be(2)
      end

      it "does not return duplicate authors if the genre has more than one book by a particular author (genre has many authors through books)" do
        Book.new({title: "The Old Man and The Sea", author: other_author, genre: genre})
        Book.new({title: "For Whom The Bell Tolls", author: other_author, genre: genre})

        expect(genre.authors).to include(other_author)
        expect(genre.authors.size).to eq(1)
      end

      it "collects authors through its books instead of maintaining its own @authors instance variable (genre has many authors through books)" do
        Book.new({title: "The Great Gatsby", author: author, genre: genre})

        expect(genre.instance_variable_defined?(:@authors)).to be_falsey
      end
    end
  end
end