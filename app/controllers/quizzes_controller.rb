class QuizzesController < ApplicationController
  ##
  # The `new` function initializes variables for a quiz, including questions, a random Pokemon list,
  # and types and abilities for the Pokemon based on the quiz questions.
  def new
    @quiz = Quiz.new
    @questions = Question.order('RANDOM()').limit(5)
    @pokemon_list = Pokemon.generate_random(5)
    @pokemon = @pokemon_list.first
    @types = []
    @abilities = []
    @types = PokemonType.generate_random(@pokemon.types, 4) if @questions.map(&:question_type).include? 'type'
    return unless @questions.map(&:question_type).include? 'ability'

    @abilities = Ability.generate_random(@pokemon_list.map(&:abilities).flatten, @pokemon.abilities, 4)
  end

  ##
  # This Ruby function creates a quiz based on user answers and calculates a score for the quiz.
  def create
    answers = answers_params
    pokemon_id = params.fetch(:pokemon_id, nil)
    pokemon = Pokemon.find pokemon_id
    score = 0
    answers.each_pair do |question, answer|
      score += 1 if Question.check_answer(pokemon, question, answer)
    end
    quiz = Quiz.create(user_id: session[:user_id], score:)
    if quiz.valid?
      redirect_to quiz_quiz_result_path(quiz), flash: { notice: 'Quiz submitted!' }
    else
      redirect_to new_quiz_path, flash: { error: 'Ups, we got an error, try to submit your quiz again' }
    end
  end

  def quiz_result
    @quiz = Quiz.find params[:quiz_id]
  end

  def answers_params
    params.require(:question).permit!
  end
end
