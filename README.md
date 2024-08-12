# PokeQuiz

Test your Poké-knowledge, test yourself.

To run this app, you'll need:

* Ruby 3.2.4

* Postgres ^12

And run this commands

* `bundle install`

* `rails db:setup`

* `rails s`

## Check users answers (API)

You can check user scores locally in `/api/v1/quizzes.json`

## Next updates

Functionality:
* Check your wrong answers
* List of all scores and their users (now only via API)
* Save your quiz answers, now only saves score
* Share to Social Media your score
* Internationalization (through i18n), for spanish language

Quiz:
* Questions added:
  - Moveset
  - Generation
  - Base stats
  - Shapes
  - Egg groups
  - Hatch times
  - Mega form (if had)
  - Growth rate
  - Catch rate (when added to pokeapi)
* Add Moves to the questions list, and their learn methods
* Add Generations to the questions
* Add base stats to the questions
* Add shapes to the questions
* Add catch rates
* Pokémon alternative forms will be added
* Multiple pokémon Quiz

We will add another quizzes:
* Quiz about moves and machines, question ideas:
  - MT50, in generation IV, equals to move... 
  - Move Thunder is of type...
  - Move Fly is of category... (physical | special | status)
  - Pokemon that learn Rock-smash...
  - Move Flamethrower description
  - Which move is an Egg move?
* Simple quiz with only sprites 
  - Each question will be an sprite and the answers will include random pokemon
* Maybe an advanced quiz of stats (all stats based on current generation)
  - Level 100 \*random pokémon\* with \*random nature\* 
