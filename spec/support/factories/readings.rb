# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :reading do |f|
  f.read_book ""
  f.reader ""
  f.start_read "2011-06-02 18:44:06"
  f.end_read "2011-06-02 18:44:06"
end