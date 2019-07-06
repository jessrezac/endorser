require "spec_helper"

RSpec.describe "Findable" do
  it "defines a module named Findable" do
    expect(defined?(Findable)).to be_truthy
    expect(Findable).to_not be_a(Class)
    expect(Findable).to be_a(Module)
  end
end

RSpec.describe "Books" do
    it "extends the Findable module" do
        book_extends_findable = Book.singleton_class.ancestors.include?(Findable::ClassMethods)
        expect(book_extends_findable).to be(true)
    end
end

RSpec.describe "Episode" do
  it "extends the Findable module" do
    episode_extends_findable = Episode.singleton_class.ancestors.include?(Findable::ClassMethods)
    expect(episode_extends_findable).to be(true)
  end
end


RSpec.describe "Author" do
  it "extends the Findable module" do
    author_extends_findable = Author.singleton_class.ancestors.include?(Findable::ClassMethods)
    expect(author_extends_findable).to be(true)
  end
end

RSpec.describe "Genre" do
  it "extends the Findable module" do
    genre_extends_findable = Genre.singleton_class.ancestors.include?(Findable::ClassMethods)
    expect(genre_extends_findable).to be(true)
  end
end

RSpec.describe "Findable" do
  let!(:book_one) { Book.create({title: "The Great Gatsby"}) }
  let!(:book_two) { Book.create({title: "The Old Man and The Sea"}) }
  let!(:author_one) { Author.create({name:"F. Scott Fitzgerald"}) }
  let!(:author_two) { Author.create({name:"Ernest Hemingway"}) }
  let!(:genre_one) { Genre.create({name:"fiction"}) }
  let!(:genre_two) { Genre.create({name:"romance"}) }

  describe ".find_by_name" do
    it "is added as a class method to classes that extend the module" do
      expect(Author).to respond_to(:find_by_name)
    end

    context "works exactly like a generic version of Book.find_by_name," do
      it "searching the extended class's @@all variable for an instance that matches the provided name" do
        expect(Author.find_by_name("Ernest Hemingway")).to be(author_two)
      end
    end

    it "isn't hard-coded" do
      expect(Genre.find_by_name("romance")).to be(genre_two)
    end
  end

  describe ".find_or_create_by_name" do
    it "is added as a class method to classes that extend the module" do
      expect(Author).to respond_to(:find_or_create_by_name)
    end

    context "works exactly like a generic version of Book.find_or_create_by_name:" do
      it "finds (does not recreate) an existing instance with the provided name if one exists in @@all" do
        expect(Author.find_or_create_by_name("Ernest Hemingway")).to be(author_two)
      end

      it "isn't hard-coded" do
        expect(Genre.find_or_create_by_name("romance")).to be(genre_two)
      end

      it "invokes .find_by_name instead of re-coding the same functionality" do
        expect(Author).to receive(:find_by_name)
        Author.find_or_create_by_name("Ernest Hemingway")
      end

      it "invokes the extended class's .create method, passing in the provided name, if an existing match is not found" do
        expect(Author).to receive(:create)
        Author.find_or_create_by_name("Gloria Steinem")
      end
    end
  end
end
