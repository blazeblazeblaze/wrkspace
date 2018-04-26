class OrganizationSearch < Searchlight::Search
  def base_query
    Organization
      .joins(:contact)
      .where(contacts: { account_id: options[:account_id] })
  end

  end

  def search_name
    query.where('name ILIKE ?', '%' + name + '%')
  end
end
