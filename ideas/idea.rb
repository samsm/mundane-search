class StoreFilter
  include MundaneSearch

  default_scope Store.scoped

  time_restriction_on :created_at do
    before :created_at_before
    after :created_at_after
  end

  exact_match_for :name, mandatory: true do
    term :exact_name_search
  end

  fulltext_match_for :description

  sortable_by :created_at, :sold, :expires_at, :name
  default_sort :name

end

params = {
  created_at_after: (Time.now - 1.year),
  created_at_before: (Time.now - 1.day),
  name: 'Old Navy',
  fulltext_match_for: 'mensware',
  sortable: [:sold, :expired_at] # also sorts by name?
  # default_sort_override: true?
}

StoreFilter.new(params).execute
