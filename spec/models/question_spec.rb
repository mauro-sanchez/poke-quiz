require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'On seed' do
    it 'All questions should be added' do
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
        expect(question.valid?).to eq(true)
      end
    end
  end

  describe 'Checking answers for Ivysaur' do
    let(:pokemon) { Pokemon.find 2 }
    context 'Answer for ability' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'ability', 'Berserk')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'ability', 'Overgrow')).to eq(true)
      end
    end
    context 'Answer for type' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'type', 'Electric')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'type', 'Grass')).to eq(true)
      end
    end
    context 'Answer for name' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'name', 'Charizard')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'name', 'Ivysaur')).to eq(true)
      end
    end
    context 'Answer for evolves to' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'evolves_to', 'Pikachu')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'evolves_to', 'Venusaur')).to eq(true)
      end
    end
    context 'Answer for evolves from' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'evolves_from', 'Feraligatr')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'evolves_from', 'Bulbasaur')).to eq(true)
      end
    end
    context 'Answer for height' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'height', '1.1 m')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'height', '1 m')).to eq(true)
      end
    end
    context 'Answer for weight' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'weight', '21 kg')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'weight', '13 kg')).to eq(true)
      end
    end
    context 'Answer for flavor_text' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'flavor_text', 'False flavor text')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'flavor_text', pokemon.flavor_text)).to eq(true)
      end
    end
    context 'Answer for Pokédex number' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'pokedex_number', 1)).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'pokedex_number', 2)).to eq(true)
      end
    end
    context 'Answer for category' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'category', 'Fire Lizard')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'category', 'Seed Pokémon')).to eq(true)
      end
    end
  end

  describe "Answers for Pokémon that doesn't evolve" do
    let(:pokemon) { Pokemon.find 250 }
    context 'Answer for evolves to' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'evolves_to', 'Raichu')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'evolves_to', "Doesn't evolve")).to eq(true)
      end
    end
    context 'Answer for evolves from' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'evolves_from', 'Ponyta')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'evolves_from', "Doesn't have pre-evolution")).to eq(true)
      end
    end
  end

  describe 'Answers for Pokémon that is second evolution' do
    let(:pokemon) { Pokemon.find 3 }
    context 'Answer for evolves from' do
      it 'Bad answer should returns false' do
        expect(Question.check_answer(pokemon, 'evolves_from', 'Igglybuff')).to eq(false)
      end
      it 'Correct answer should returns true' do
        expect(Question.check_answer(pokemon, 'evolves_from', 'Ivysaur')).to eq(true)
      end
    end
  end
end
