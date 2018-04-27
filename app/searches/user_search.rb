class UserSearch < Searchlight::Search
  def base_query
    User.where(account_id: options[:account_id])
  end
end
