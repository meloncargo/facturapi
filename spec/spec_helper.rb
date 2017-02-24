$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'facturapi'
require 'pry'

I18n.load_path << File.expand_path('./spec/support/locale/en.yml')
