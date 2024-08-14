require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the QuizzesHelper. For example:
#
# describe QuizzesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe QuizzesHelper, type: :helper do
  describe '#generate_answers' do
    let(:pokemon_array) { Pokemon.generate_random(5) }
    let(:pokemon) { pokemon_array.first }
    let(:types) { PokemonType.generate_random(pokemon.types, 4) }
    let(:abilities) { Ability.generate_random(pokemon_array.map(&:abilities).flatten, pokemon.abilities, 4) }

    it 'Generated array of answers for question type "ability" should have the correct answer' do
      expect(helper.generate_answers('ability', pokemon_array, abilities,
                                     types)).to include(pokemon.abilities.first.gsub('-', ' ').capitalize)
    end
    it 'Generated array of answers for question type "type" should have the correct answer' do
      expect(helper.generate_answers('type', pokemon_array, abilities,
                                     types)).to include(pokemon.types.first.capitalize)
    end
    it 'Generated array of answers for question type "name" should have the correct answer' do
      expect(helper.generate_answers('name', pokemon_array, abilities, types)).to include(pokemon.name.capitalize)
    end
    it 'Generated array of answers for question type "evolves_to" should have the correct answer' do
      expect(helper.generate_answers('evolves_to', pokemon_array, abilities,
                                     types)).to include((pokemon.evolves_to.first || "Doesn't evolve").capitalize)
    end
    it 'Generated array of answers for question type "evolves_from" should have the correct answer' do
      expect(helper.generate_answers('evolves_from', pokemon_array, abilities,
                                     types)).to include((pokemon.evolves_from || "Doesn't have pre-evolution").capitalize)
    end
    it 'Generated array of answers for question type "height" should have the correct answer' do
      expect(helper.generate_answers('height', pokemon_array, abilities,
                                     types)).to include("#{number_with_precision(pokemon.height * 0.1, precision: 2,
                                                                                                       strip_insignificant_zeros: true)} m")
    end
    it 'Generated array of answers for question type "weight" should have the correct answer' do
      expect(helper.generate_answers('weight', pokemon_array, abilities,
                                     types)).to include("#{number_with_precision(pokemon.weight * 0.1, precision: 2,
                                                                                                       strip_insignificant_zeros: true)} kg")
    end
    it 'Generated array of answers for question type "flavor_text" should have the correct answer' do
      expect(helper.generate_answers('flavor_text', pokemon_array, abilities, types)).to include(pokemon.flavor_text)
    end
    it 'Generated array of answers for question type "pokedex_number" should have the correct answer' do
      expect(helper.generate_answers('pokedex_number', pokemon_array, abilities,
                                     types)).to include(pokemon.pokedex_number)
    end
    it 'Generated array of answers for question type "category" should have the correct answer' do
      expect(helper.generate_answers('category', pokemon_array, abilities, types)).to include(pokemon.category)
    end
  end

  describe 'generate_text_from_score' do
    it 'Generate feedback with 0 score' do
      expect(helper.generate_text_from_score(0)).to eq('Whops! Seems you need to take more Poké-lessons')
    end
    it 'Generate feedback with 1 score' do
      expect(helper.generate_text_from_score(1)).to eq('Bad luck! Looks like you need to play more Pokémon games')
    end
    it 'Generate feedback with 2 score' do
      expect(helper.generate_text_from_score(2)).to eq('Not bad, but you will do better if you take classes from a Pokémon tutor')
    end
    it 'Generate feedback with 3 score' do
      expect(helper.generate_text_from_score(3)).to eq('Nice, but you can do better! Give another chance!')
    end
    it 'Generate feedback with 4 score' do
      expect(helper.generate_text_from_score(4)).to eq("Awesome! You're on your way to became a Pokémon Master")
    end
    it 'Generate feedback with 5 score' do
      expect(helper.generate_text_from_score(5)).to eq('Whoa! Are you professor Oak? Or you checked Bulbapedia? Congratulations!')
    end
  end
end
