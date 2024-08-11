# frozen_string_literal: true

class Ability < PokeModel
  def self.generate_random(_ary, _exclude, _times)
    (_ary.filter do |a|
       _exclude.exclude? a
     end.take(_times) << _exclude[0]).shuffle.map { |ab| ab.gsub('-', ' ').capitalize }
  end
end
