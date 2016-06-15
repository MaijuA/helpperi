require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
   add_filter 'app/controllers/categories_controller.rb', 'app/controllers/info_controller.rb'
end
