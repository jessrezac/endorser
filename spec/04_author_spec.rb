require "spec_helper"

RSpec.describe "Author" do
    let(:author) { Author.new({name:"Thomas Piketty"}) }
  
    describe "#initialize" do
      it "accepts a name for the new author" do
        new_author = Author.new({name: "Tim Ferris"})
  
        new_author_name = new_author.instance_variable_get(:@name)
  
        expect(new_author_name).to eq("Tim Ferris")
      end
    end
  
    describe "#name" do
      it "retrieves the name of an author" do
        expect(author.name).to eq("Thomas Piketty")
      end
    end
  
    describe "#name=" do
      it "can set the name of an author" do
        author.name = "Malcolm Gladwell"
  
        author_name = author.instance_variable_get(:@name)
  
        expect(author_name).to eq("Malcolm Gladwell")
      end
    end
  
    describe "@@all" do
      it "is initialized as an empty array" do
        all = Author.class_variable_get(:@@all)
  
        expect(all).to match_array([])
      end
    end
  
    describe ".all" do
      it "returns the class variable @@all" do
        expect(Author.all).to match_array([])
  
        Author.class_variable_set(:@@all, [author])
  
        expect(Author.all).to match_array([author])
      end
    end
  
    describe ".destroy_all" do
      it "resets the @@all class variable to an empty array" do
        Author.class_variable_set(:@@all, [author])
  
        Author.destroy_all
  
        expect(Author.all).to match_array([])
      end
    end
  
    describe "#save" do
      it "adds the Author instance to the @@all class variable" do
        author.save
  
        expect(Author.all).to include(author)
      end
    end
  
    describe ".create" do
      it "initializes and saves the author" do
        created_author = Author.create({name:"Margaret Atwood"})
  
        expect(Author.all).to include(created_author)
      end
    end
  end