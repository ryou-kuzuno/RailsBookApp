class ApplicationController < ActionController::Base
    def _footer
        @user = User.find_by(id: params[:id])
    end

end
