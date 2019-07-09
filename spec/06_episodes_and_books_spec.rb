require "spec_helper"

RSpec.describe "Associations — Episode and Book:" do
    let(:episode) { Episode.new({title: "An episode of the ezra klein show",  
        description: "",
        date: "10/31/2019",
        link: "http://player.fm/the-ezra-klein-show"}) }
    let(:book) { Book.new({title: "The Great Gatsby", 
        author: Author.new({name: "F. Scott Fitzgerald"}), 
        synopsis: "The description of the book",
        genre: Genre.new("fiction")}) }

  context "Episode" do
    describe "#initialize" do
      it "creates a 'books' property set to an empty array (Episode may have many books)" do
        expect(episode.instance_variable_defined?(:@books)).to be(true)
        expect(episode.instance_variable_get(:@books)).to eq([])
      end
    end

    describe "#books" do
      it "returns the episodes's 'books' collection (episode may have many books)" do
        expect(episode.books).to eq([])

        episode.books << book

        expect(episode.books).to include(book)
      end
    end
  end

  context "Book" do

    describe "#episode" do
      it "returns the episode of the book (book belongs to episode)" do
        book.instance_variable_set(:@episode, episode)

        expect(book.episode).to be(episode)
      end
    end

    describe "#episode=" do
      it "assigns an episode to the book (book belongs to episode)" do
        book.episode = episode

        assigned_episode = book.instance_variable_get(:@episode)

        expect(assigned_episode).to include(episode)
      end
    end
  end

  context "Episode" do
    describe "#add_book" do
      it "assigns the current episode to the book's 'episode' property (book belongs to episode)" do
        episode.add_book(book)

        expect(book.episode).to include(episode)
      end

      it "adds the book to the current episode's 'books' collection" do
        episode.add_book(book)

        expect(episode.books).to include(book)
      end

      it "does not add the book to the current episode's collection of books if it already exists therein" do
        2.times { episode.add_book(book) }

        expect(episode.books).to include(book)
        expect(episode.books.size).to be(1)
      end
    end
  end

  context "Book" do
    describe "#episode=" do
      it "invokes Episode#add_book to add itself to the episode's collection of books (episode has many books)" do
        expect(episode).to receive(:add_book)

        book.episode = episode
      end
    end

    describe "#initialize" do
      it "invokes #episode= instead of simply assigning to an @episode instance variable to ensure that associations are created upon initialization" do
        expect_any_instance_of(Book).to receive(:episode=).with(episode)

        Book.new({title:"Alice In Wonderland", episode: episode})
      end
    end
  end
end
