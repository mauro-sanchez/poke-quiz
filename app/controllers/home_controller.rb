class HomeController < ApplicationController
  skip_before_action :is_not_logged
end
