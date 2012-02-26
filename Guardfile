# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end

guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'cucumber' },
               :rspec_env => { 'RAILS_ENV' => 'test' },
               :wait => 50 do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/routes.rb')
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch('spec/spec_helper.rb')
  watch('Gemfile.lock')
end

guard 'rspec', :cli => "--drb --format Fuubar",:all_on_start => false  do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }

  # Rails example
  watch('spec/spec_helper.rb')                       { "spec" }
  watch('config/routes.rb')                          { "spec/routing" }
  watch('app/controllers/application_controller.rb') { "spec/controllers" }
  watch('db/schema.rb')                              { "spec/models" }
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^app/(.+)\.rb})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^lib/(.+)\.rb})                           { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
end

guard 'cucumber', :notification => false, 
                  :all_on_start => false, 
                  :cli => ' --format Cucumber::Formatter::Fuubar -p guard', 
                  :change_format => 'Slowhandcuke::Formatter'   do
  watch(%r{^features/.+\.feature$})
end

guard 'sass' do
  watch(%r{^sass/.+\.s[ac]ss})
end

# # Optionally set output directory, defaults to 'css'
# guard 'sass', :output => 'public/css' do
#   watch(%r{^sass/.+\.s[ac]ss})
# end

guard 'compass' do
  watch(%r{app/stylesheets/(.*)\.s[ac]ss})
end

guard 'coffeescript', :input => 'app/scripts'
