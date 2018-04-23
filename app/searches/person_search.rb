class PersonSearch < Searchlight::Search
  def base_query
    Person.all
  end

  def search_name
    query
      .where('first_name ILIKE ? OR last_name ILIKE ?', '%' + name + '%', '%' + name + '%')
  end

  def search_organization_id
    query.where(organization_id: organization_id)
  end
end
