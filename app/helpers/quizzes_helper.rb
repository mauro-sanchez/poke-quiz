module QuizzesHelper
  def url_image_for_pokemon(id)
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/#{id}.png"
  end

  ##
  # The function `generate_answers` takes in parameters such as type, pokemon_array, abilities, and
  # types, and returns specific information based on the type specified.
  #
  # Args:
  #   type: The `type` parameter in the `generate_answers` method determines what kind of information
  # should be generated for the given input. The possible values for the `type` parameter are: name,
  # abilities, types, height, weight, flavor text, pokedex number, category, and evolution
  # details (evolves_to and evolves_from)
  #   pokemon_array: Array of Pokémon objects. Each Pokémon object contains information.
  #   abilities: Array containing different abilities of Pokémon.
  #   types: Array containing different types of Pokémon.
  def generate_answers(type, pokemon_array, abilities, types)
    case type
    when 'ability'
      abilities
    when 'type'
      types.map(&:capitalize)
    when 'name'
      pokemon_array.map(&:name).map(&:capitalize)
    when 'evolves_to'
      list = Pokemon.get_all_pokemon_list_in_array(pokemon_array.drop(1))
      list.push(pokemon_array.first.evolves_to.first || "Doesn't evolve")
      list.shuffle.map(&:capitalize)
    when 'evolves_from'
      list = Pokemon.get_all_pokemon_list_in_array(pokemon_array.drop(1))
      list.push(pokemon_array.first.evolves_from || "Doesn't have pre-evolution")
      list.shuffle.map(&:capitalize)
    when 'height'
      pokemon_array.map(&:height).map do |h|
        "#{number_with_precision(h * 0.1, precision: 2, strip_insignificant_zeros: true)} m"
      end.shuffle
    when 'weight'
      pokemon_array.map(&:weight).map do |w|
        "#{number_with_precision(w * 0.1, precision: 2, strip_insignificant_zeros: true)} kg"
      end.shuffle
    when 'flavor_text'
      pokemon_array.map(&:flavor_text).shuffle
    when 'pokedex_number'
      list = ([*1..800] - [pokemon_array.first.pokedex_number]).sample(4)
      list.push pokemon_array.first.pokedex_number
      list.shuffle
    when 'category'
      pokemon_array.map(&:category).shuffle
    end
  end

  ##
  # The function `generate_text_from_score` takes a score as input and returns a corresponding message
  # based on the score in relation to Pokémon proficiency.
  #
  # Args:
  #   score: The `generate_text_from_score` method takes a `score` as input and returns a message
  def generate_text_from_score(score)
    case score
    when 0
      'Whops! Seems you need to take more Poké-lessons'
    when 1
      'Bad luck! Looks like you need to play more Pokémon games'
    when 2
      'Not bad, but you will do better if you take classes from a Pokémon tutor'
    when 3
      'Nice, but you can do better! Give another chance!'
    when 4
      "Awesome! You're on your way to became a Pokémon Master"
    when 5
      'Whoa! Are you professor Oak? Or you checked Bulbapedia? Congratulations!'
    end
  end
end
