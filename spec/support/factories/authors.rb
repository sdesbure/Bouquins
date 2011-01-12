# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :author do |f|
  f.name "MyString"
  f.first_name "MyString"
  f.nickname "MyString"
  f.wikipedia_url ""
  f.image_url ""
end
