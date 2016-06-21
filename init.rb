APP_ROOT=File.dirname(__FILE__)
root=$:.unshift(File.join(APP_ROOT,'lib'))
require 'guide'
guide=Guide.new('restourant .txt')
guide.launch!
