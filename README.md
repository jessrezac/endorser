# Podcast Book Club

[__The Ezra Klein Show__](https://www.vox.com/ezra-klein-show-podcast) brings you far-reaching conversations about hard problems, big ideas, illuminating theories, and cutting-edge research.

__Podcast Book Club__ is a command line interface that scrapes each episode for book recommendations, building a library and allowing the user to explore their bookshelf by genre, author, or keyword.

Listen to The Ezra Klein Show at [Player.fm](https://player.fm/series/the-ezra-klein-show/) or check out other [Vox Media Podcasts](https://www.vox.com/pages/podcasts).


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'podcast-book-club'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install podcast-book-club

## Getting Started

Before using Podcast Book Club you must create a new Google Books application. Visit [Google Books APIs](https://developers.google.com/books/docs/v1/using#APIKey) for details.

Create a file `config/api.rb` in `config/` and copy and paste the following code:

``` ruby
# Google Books key
def googlebooks_config
    {:api_key => <your-api-key>}
end
```

## Usage

Type the code below and follow the prompts to explore book recommendations.

``` bash
$ podcast_book_club
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jessrezac/podcast-book-club. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Podcast Book Club project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jessrezac/podcast-book-club/blob/master/CODE_OF_CONDUCT.md).
