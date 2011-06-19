# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :owning do |f|
  f.owned_edition ""
  f.owner ""
end