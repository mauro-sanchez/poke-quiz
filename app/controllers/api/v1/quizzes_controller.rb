class Api::V1::QuizzesController < ApplicationController
  skip_before_action :is_not_logged

  def index
    quizzes = Quiz.all
    render json: quizzes
  end
end
