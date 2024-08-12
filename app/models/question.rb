class Question < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  # This Ruby code defines a class method `check_answer` inside the `Question` class. This method
  # takes three arguments: `pokemon`, `type`, and `answer`.
  def self.check_answer(pokemon, type, answer)
    case type
    when 'ability'
      pokemon.abilities.first.gsub('-', ' ').capitalize == answer
    when 'type'
      pokemon.types.first.capitalize == answer
    when 'name'
      pokemon.name.capitalize == answer
    when 'evolves_to'
      if pokemon.evolves_to.first.blank?
        "Doesn't evolve" == answer
      else
        pokemon.evolves_to.first.capitalize == answer
      end
    when 'evolves_from'
      if pokemon.evolves_from.blank?
        "Doesn't have pre-evolution" == answer
      else
        pokemon.evolves_from.capitalize == answer
      end
    when 'height'
      "#{ActionController::Base.helpers.number_with_precision(pokemon.height * 0.1, precision: 2,
                                                                                    strip_insignificant_zeros: true)} m" == answer
    when 'weight'
      "#{ActionController::Base.helpers.number_with_precision(pokemon.weight * 0.1, precision: 2,
                                                                                    strip_insignificant_zeros: true)} kg" == answer
    when 'flavor_text'
      pokemon.flavor_text == answer
    when 'pokedex_number'
      pokemon.pokedex_number == answer
    when 'category'
      pokemon.category == answer
    end
  end
end
