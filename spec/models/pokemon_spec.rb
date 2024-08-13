require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  describe 'On Fetching Bulbasaur' do
    pokemon = Pokemon.find 1
    it 'Would have first evolution' do
      expect(pokemon.has_first_evol?).to eq(true)
    end
    it 'Would have second evolution' do
      expect(pokemon.has_second_evol?).to eq(true)
    end
    it 'Should evolve to Ivysaur' do
      expect(pokemon.evolves_to.first).to eq('ivysaur')
    end
    it 'Should be of grass and venom types' do
      expect((pokemon.types & %w[grass venom]).any?).to eq(true)
    end
  end

  describe 'On Fetching MewTwo' do
    pokemon = Pokemon.find 150
    it "Wouldn't have first evolution" do
      expect(pokemon.has_first_evol?).to eq(false)
    end
    it "Wouldn't have second evolution" do
      expect(pokemon.has_second_evol?).to eq(false)
    end
    it 'Should be of psychic type' do
      expect(pokemon.types.include?('psychic')).to eq(true)
    end
  end
end
