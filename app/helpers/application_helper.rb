module ApplicationHelper
  def pretty_date(date)
    return unless date
    date.strftime('%D')
  end

  def current_class?(lookup_path)
    request.path == lookup_path ? 'active' : ''
  end
end
