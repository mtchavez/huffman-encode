require 'minitest/autorun'
require 'minitest/spec'
require 'fileutils'
Dir[File.join(FileUtils.pwd, 'lib/**/*.rb')].each { |file| require file }
ENV['environment'] = 'test'
