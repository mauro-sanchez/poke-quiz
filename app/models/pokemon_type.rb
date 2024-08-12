# frozen_string_literal: true

require 'poke-api-v2'
class PokemonType < PokeModel
  # This method `generate_random` in the `PokemonType` class is defined to generate a random list of Pokémon types.
  def self.generate_random(_exclude, _times)
    api_types = PokeApi.get(:type)
    (api_types.results.map(&:name).filter { |t| _exclude.exclude? t }.take(_times) << _exclude[0]).shuffle
  end
end
