module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      resource = create(:user)
      resource.confirm
      sign_in resource
    end
  end

  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      resource = create(:admin)
      resource.confirm
      sign_in resource
    end
  end
end
