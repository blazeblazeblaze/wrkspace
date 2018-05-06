class TaskSearch < Searchlight::Search
  def base_query
    Task.where(user_id: options[:user_id])
  end
end
