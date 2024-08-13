module Features
  module QuizHelpers
    def fill_questions
      [
        { description: 'Pokémon name', question_type: :name },
        { description: 'Which ability does this pokémon have?', question_type: :ability },
        { description: 'This pokémon evolves to', question_type: :evolves_to },
        { description: 'This pokémon evolves from', question_type: :evolves_from },
        { description: 'Height of this pokémon?', question_type: :height },
        { description: 'Weight of this pokémon', question_type: :weight },
        { description: 'Type of this pokémon?', question_type: :type },
        { description: 'Pokédex flavor text', question_type: :flavor_text },
        { description: 'National Pokédex number', question_type: :pokedex_number },
        { description: 'Pokémon category', question_type: :category }
      ].each do |question|
        question = FactoryBot.create(:question, description: question[:description],
                                                question_type: question[:question_type])
        question.save
      end
    end
  end
end
