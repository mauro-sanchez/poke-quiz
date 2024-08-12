class Api::V1::QuizzesController < ApplicationController
  skip_before_action :is_not_logged

  def index
    # List all of quizzes, jbuilder will be used to filter data
    @quizzes = Quiz.all
    # render json: @quizzes
  end
end
