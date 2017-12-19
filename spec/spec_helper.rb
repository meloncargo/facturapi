$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'facturapi'
require 'pry'

I18n.load_path << File.expand_path('./spec/support/locale/en.yml')

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end
