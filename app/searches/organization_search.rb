class OrganizationSearch < Searchlight::Search
  def base_query
    Organization.all
  end

  def search_name
    query.where('name ILIKE ?', '%' + name + '%')
  end
end
