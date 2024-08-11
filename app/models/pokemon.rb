# frozen_string_literal: true

require 'hashie'
require 'poke-api-v2'
class Pokemon < PokeModel
  def self.generate_random(_times)
    pokemon_ids = (1...800).to_a.sort { rand - 0.5 }[1.._times]
    pokemon_ids.map do |id|
      Pokemon.new poke_hash(PokeApi.get(pokemon: id))
    end
  end

  def self.find(id)
    Pokemon.new poke_hash(PokeApi.get(pokemon: id))
  end

  def self.poke_hash(pokemon)
    poke_data = pokemon.species.get
    evol_chain = poke_data.evolution_chain.get
    current_pokemon_name = pokemon.name
    {
      id: pokemon.id,
      name: current_pokemon_name.gsub('-', ' '),
      abilities: pokemon.abilities.map(&:ability).map(&:name),
      types: pokemon.types.map(&:type).map(&:name),
      height: pokemon.height,
      weight: pokemon.weight,
      flavor_text: poke_data.flavor_text_entries.filter { |entry| entry.language.name == 'en' }.last.flavor_text,
      pokedex_number: poke_data.pokedex_numbers.find do |_pokedex_n|
                        _pokedex_n.pokedex.name == 'national'
                      end.entry_number,
      evolution_chain: {
        base: { name: evol_chain.chain.species.name },
        evolutions: evol_chain.chain.evolves_to.map do |first_evol|
          {
            name: first_evol.species.name,
            evolutions: first_evol.evolves_to.map do |second_evol|
              {
                name: second_evol.species.name
              }
            end
          }
        end
      }
    }
  end

  def is_base?
    evolution_chain.base.name == name
  end

  def has_first_evol?
    evolution_chain.evolutions.length > 0
  end

  def is_first_evol?
    if has_first_evol?
      evolution_chain.evolutions.map(&:name).include? name
    else
      false
    end
  end

  def has_second_evol?
    if has_first_evol?
      evolution_chain.evolutions.map(&:evolutions).length > 0
    else
      false
    end
  end

  def is_second_evol?
    return unless has_second_evol?

    evolution_chain.evolutions.map(&:evolutions).flatten.map(&:name).include? name
  end

  def evolves_from
    if is_base?
      nil
    elsif is_first_evol?
      evolution_chain.base.name
    else
      first_evol = evolution_chain.evolutions.find { |first_evol| first_evol.evolutions.map(&:name).include? name }
      first_evol&.name
    end
  end

  def evolves_to
    if is_base? && has_first_evol?
      evolution_chain.evolutions.map(&:name)
    elsif is_first_evol? && has_second_evol?
      evolution_chain.evolutions.find { |first_evol| first_evol.name == name }.evolutions.map(&:name)
    else
      []
    end
  end

  def self.get_all_pokemon_list_in_array(pokemon_array)
    pokemon_list = []
    pokemon_array.each do |pkm|
      pokemon_list << pkm.evolution_chain.base.name
      pokemon_list.push(*pkm.evolution_chain.evolutions.map(&:name)) if pkm.has_first_evol?
      pokemon_list.push(*pkm.evolution_chain.evolutions.map(&:evolutions).flatten.map(&:name)) if pkm.has_second_evol?
    end
    pokemon_list.compact.uniq.sample(4)
  end
end
