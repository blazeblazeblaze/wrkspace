module Admin
  class UsersController < Admin::BaseController
    before_action :load_users, only: [:index, :suspend]

    def index; end

    def new
      @invitation_form = AccountInvitationForm.new
    end

    def create
      @invitation_form = AccountInvitationForm.new(invitation_form_params)

      if @invitation_form.save
        flash[:success] = 'Successfully invited new user!'
        redirect_to admin_users_path
      else
        flash[:error] = @invitation_form.errors.messages
        render :new
      end
    end

    def suspend
      @user = @users.find(params[:user_id])

      if @user.suspend!
        flash[:success] = 'Successfully suspened this user!'
      else
        flash[:error] = 'There was a problem with suspending this user.'
      end

      redirect_to admin_users_path
    end

    private
    def invitation_form_params
      params.require(:account_invitation_form).permit(
        :email).merge(user_id: current_user.id)
    end

    def load_users
      @users ||= UserSearch.new(account_id: current_user.account_id).results
    end
  end
end
