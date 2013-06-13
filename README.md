# MundaneSearch

MundaneSearch aims to compartmentalize multi-step search.

## Installation

You know the deal:

    gem 'mundane-search' # in your Gemfile, then "bundle"
    # or just gem install mundane-search on your command line
    require "mundane-search"

## Usage

*Still in the process of figuring this out! But much of it works like I want, so hopefully no brutal changes.*

Build a search, then run that search on a specific collection and params.

Collections are typically array-like structures (arrays, ActiveRecord or Sunspot scoped collections, etc.)

Params are hash-like structures, such as those interpreted from forms and query strings. They are optional.

Create a search:

    class BookSearch < MundaneSearch::Result
    end

Add filters to it:

    class BookSearch < MundaneSearch::Result
      use :attribute_match, param_key: "title"
    end

Then use that search in your controllers:

    # params = { "book_search" => { "title" => "A Tale of Two Cities" } }
    @result = BookSearch.results_for(Book.scoped, params["book_search"])

The returned result is enumerable:

    @result.each {|book| ... }
    @result.first

And has some Rails-style form compatibility:

    <%= search_form_for(@result) do |f| %>
      <%= f.input :title %>
    <% end %>

## Filters

There are built in filters and you can make your own filters.

Three ways to notate filters:

    class ExampleSearch < MundaneSearch::Result
      use FilterClass
      use :filter_class
      employ :shortcut
    end

1.  use FilterClass, options
    The most straightforward. Under the hood, this establishes that a searched collection will be
    passed through this filter.
2.  use :filter_class, options
    This is the same as specifying FilterClass, except MundaneSearch will look for filter_class
    in MundaneSearch::Filters if it isn't found in the Object namespace.
3.  employ :shortcut, options
    This is the avenue for shortcuts, such as when you might want several filters to be created
    by one designation.
    I haven't spent much thought on this, it may change in the future.


## Built in filters

### Common options

First some options that are common to many filters.

* param_key: The key in params to examine for a matching value.
* target: The attribute to match against. By default, uses param_key.
* match_value: Usually nil. When nil, the value of params[param_key] is used.
* required: Default false. When true, will run a filter even if (for example) the match_value is nil.
* type: Gives form helpers et al a hint as to what type the match_value should be. Overrides class method param_key_type in a filter.
  Available types:
  1. :string
  2. :integer
  3. :float
  4. :date
  5. :time

All those suckers in action:

    class BookSearch < MundaneSearch::Result
      # book.publisher == params["publisher"] even if the match_value (params["publisher"]) is nil
      # (in below examples, the filter is skipped if the match_value is nil)
      use :attribute_match, param_key: "publisher", required: true

      # book.title == params["title"]
      use :attribute_match, param_key: "title"

      # book.author == params["writer"]
      use :attribute_match, param_key: "writer", target: "author"

      # book.publication_date > Date.parse("1900-01-01") (disregards params)
      use :operator, param_key: "publication_date", operator: :>, match_value: Date.parse("1900-01-01")

      # simple_form displays filter as designated type
      use :attribute_match, param_key: "first_purchased_at", type: :time
    end

### AttributeMatch

Returns objects that exactly match an attribute, ex: book.title == "A Tale of Two Cities"

    use :attribute_match, param_key: "title"

### AttributeSubstring

Returns objects that match a portion of an attribute, ex: book.title =~ /Tale of/

    use :attribute_substring, param_key: title

### Operator

Returns objects that match an attribute + operator, ex: book.publication_date > Date.parse("1900-01-01")

Requires a param_key and a symbol of an operator (:>, :<, :>=, :<=)

    use :operator, param_key: "publication_date", operator: :>

### Order

Sorts a collection.

    use :order, param_key: "sort", direction: "asc"


#### ExactMatch

MundaneSearch can also work with objects that aren't "attribute-y".

Return objects that are equal to the match_value. Used in a lot of examples below.

### BlankParamsAreNil

The params can be manipulated.

Changes values of "", [], or {} to nil in params.

## Sans sugar

MundaneSearch can be used outside of Rails on whatever sort of object you want:

    built = MundaneSearch::Builder.new do
      use MundaneSearch::Filters::ExactMatch, param_key: "fruit"
    end
    built.call %w(apple orange blueberry), { 'fruit' => 'orange' } # ["orange"]

If you git checkout the project, ./script/console will get you a session with everything loaded up.

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
    built.call %w(CA TX NY FL IL) # ['CA','NY','IL']

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

### A shortcut for referencing filters

If a filter is defined directly under MundaneSearch::Filters or Object (such as when you just define a class without a namespace), you can reference it with a underscored version of that filter.

The following two "use" designations would use the same filter.

    MundaneSearch::Builder.new do
      use MundaneSearch::Filters::ExactMatch, param_key: "foo"
      use :exact_match, param_key: "foo"
    end

Object is searched first, so a user defined ExactMatch would take precedence over the MundaneSearch::Filters one.

## Supporting multiple collection types

MundaneSearch can work with any collection object that can be passed around and modified. Filters can be designed to work with several types of collection.

When a filter is about to be built, MundaneSearch looks at the base class of the collection being searched and checks to see if there is a subclass with the same name.

In the following example, the ActiveRecord subclass will be used instead of the OnlyManagers class when the collection is an instance of ActiveRecord::Relation.

    class OnlyManagers < MundaneSearch::Filters::Base
      class ActiveRecord < self
        def filtered_collection
          collection.where(postion: "manager")
        end
      end
      def filtered_collection
        collection.select {|e| e.position == "manager" }
      end
    end


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
