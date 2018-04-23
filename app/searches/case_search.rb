class CaseSearch < Searchlight::Search
  def base_query
    Case.all
  end

  def search_name
    query.where('name ILIKE ?', '%' + name + '%')
  end

  def search_state
    case state
    when 'all'
      query
    when 'open'
      query.where(closed_at: nil)
    when 'close'
      query.where.not(closed_at: nil)
    end
  end

  def search_contact_id
    query.where(contact_id: contact_id)
  end
end
