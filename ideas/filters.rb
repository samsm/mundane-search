filters.order.each do |filter|
  # current_search.where(["expires_at < ?", date])
  filter.apply_to(current_search, params)
end

class Filter
  attr_accessor :search_tactic_method_name

  # This needs to establish
  # * Search tactic
  # * Field target(s)
  # * Optional?
  # * Validations
  # {
  #   target: 'created_at',
  #   search_type: 'time',
  #   optional: true,
  #   validate_with: ->(val) { val.kind_of?(Time) }, # or /\A\S{4,}\Z/
  #   validations: [],
  #   error_on_validate: false
  # }
  def initialize(opts = {})

  end

  def apply_to(current_search_object, params)
    search_mechanism.public_send(search_tactic_method_name,
                                 current_search_object,
                                 extract_params)
  end

  def extract_params
    params[:search]
  end
end