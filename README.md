# MundaneSearch

MundaneSearch aims to compartmentalize multi-step search.

## Installation

You know the deal:

    gem 'mundane-search' # in your Gemfile, then "bundle"
    # or just gem install mundane-search on your command line

## Usage

Build a search using middleware, then run that search on a specific collection and params.

Collections are typically array-like structures (arrays, ActiveRecord or Sunsport scoped collections, etc.)

Params are hash-like structures, such as those interpreted from forms and query strings.

    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::ExactMatch, param_key: "fruit"
    end
    built.call %w(apple orange blueberry), { 'fruit' => 'orange' } # ["orange"]

## Middleware

Make your own filters! Here's how:

    class MustContainVowel < MundaneSearch::Filters::Base
      def filtered_collection
        collection.select {|e| e =~ /[aeiouy]/i} # only elements that contain a vowel
      end
    end

Then you can reference that filter when you build a search:

    built = MundaneSearch::Builder.new do
      use MustContainVowel
    end
    built.call %w(CA TX NY FL IL), {} # ['CA','NY','IL']

Filters are more useful when they are reusable. Arguments passed after the filter name (use Filter, arguments) will be passed into the filter's constructer.
The Base filter in these examples sets an "options" variable with this argument.

    class MustMatch < MundaneSearch::Filters::Base
      def filtered_collection
        collection.select {|e| e.match(options[:regex]) }
      end
    end
    built = MundaneSearch::Builder.new do
      use MustMatch, regex: /\A[a-m]+\Z/i
      use MustMatch, regex: /L/
    end
    built.call %w(CA TX NY FL IL) # ["FL", "IL"]

Filters will often be configured to consider input on a specific search. So, you'd configure your filter to pull values from params to limit results.

    class MatchIfNameEqual < MundaneSearch::Filters::Base
      def filtered_collection
        collection.select {|e| e == params[:name] }
      end
    end
    built = MundaneSearch::Builder.new do
      use MatchIfNameEqual
    end
    built.call %w(Bill Bush Barack), { name: "Bill" } # ["Bill"]

This is another filter that would be more useful if instead of being hard-wired to look at params[:name], it could be configured when it is used.
A supplied filter: ExactMatch, does just this.

built = MundaneSearch::Builder.new do
  use MundaneSearch::Filters::ExactMatch, param_key: "title"
end
built.call %w(Private Sergeant Lieutenant), { "title" => "Sergeant" } # ["Sergeant"]

It also ignores empty params:

    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::ExactMatch, param_key: "title"
    end
    built.call %w(Private Sergeant Lieutenant), { "title" => nil } # ["Private", "Sergeant", "Lieutenant"]

Unless you tell it not to (in the following case, the filter will look for an exact match on nil, and not find it):

    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::ExactMatch, param_key: "title", required: true
    end
    built.call %w(Private Sergeant Lieutenant), { "title" => nil } # []

You can alter params as well, in a similar fashion.

    class AlwaysSearchingForGumbo < MundaneSearch::Filters::Base
      def filtered_params
        params.merge({ options[:param_key] => "Gumbo" })
      end
    end
    built = MundaneSearch::Builder.new do
      use AlwaysSearchingForGumbo, param_key: "food"
      use MundaneSearch::Filters::ExactMatch, param_key: "food"
    end
    built.call %w(Pizza Pasta Antipasto Gumbo), { "food" => "Pizza" } # ["Gumbo"]
    built.call %w(Pizza Pasta Antipasto Gumbo) # ["Gumbo"]

So yeah, it's fun. Here's a more practical example ... if you have clients that pass in groups of empty parameters (intending for those to not influence the search) BlankParamsAreNil will turn those empty strings into nil values.

    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::BlankParamsAreNil
      use MundaneSearch::Filters::ExactMatch, param_key: "food"
      use MundaneSearch::Filters::ExactMatch, param_key: "noms"
    end
    built.call %w(Pizza Pasta Antipasto Gumbo), { "food" => "", "noms" => "Gumbo" } # ["Gumbo"]

## ActiveRecord

MundaneSearch can work with any collection object that can be passed around and modified. Filters can be designed to work with several types of collection.

    class OnlyManagers < MundaneSearch::Filters::Base
      def filtered_collection
        case collection
        when ActiveRecord::Relation
          collection.where(postion: "manager")
        else
          collection.select {|e| e.position == "manager" }
        end
      end
    end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
