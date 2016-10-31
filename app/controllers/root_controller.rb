class RootController < ApplicationController
  skip_before_action :verify_permissions
end
