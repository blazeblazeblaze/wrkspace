class OrganizationSearch < Searchlight::Search
  def base_query
    Organization
      .joins(:contact)
      .where(contacts: { account_id: options[:account_id] })
  end

  def search_with_cases
    return query unless with_cases == '1'
    query.includes(:cases).where(cases: { closed_at: nil })
  end

  def search_name
    query.where('name ILIKE ?', '%' + name + '%')
  end
end
