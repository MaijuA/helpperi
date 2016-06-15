require 'simplecov'
require 'coveralls'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
   add_filter 'app/controllers/categories_controller.rb'
   add_filter 'app/controllers/info_controller.rb'
   add_filter 'app/controllers/admin_controller.rb'
end
