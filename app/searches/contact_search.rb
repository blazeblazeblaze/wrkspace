class ContactSearch < Searchlight::Search
  def base_query
    Contact
      .includes(:contactable)
      .where(account_id: options[:account_id])
  end

  def search_circle_id
    query
      .joins(:circles)
      .where(circles: { id: circle_id })
  end

  def search_type
    query.where(contactable_type: type)
  end
end
