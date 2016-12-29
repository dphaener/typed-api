module Predicates
  include Dry::Logic::Predicates

  predicate(:email?) do |value|
    ! /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.match(value).nil?
  end
end
