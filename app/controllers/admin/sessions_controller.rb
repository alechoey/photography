class Admin::SessionsController < Devise::SessionsController
  # Don't inherit from Admin::ApplicationsController so you can log in
end