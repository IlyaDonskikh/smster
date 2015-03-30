require 'rails/generators'
module Smster
  class InstallGenerator < Rails::Generators::Base
    desc "Some description of my generator here"

    # Commandline options can be defined here using Thor-like options:
    class_option :my_opt, :type => :boolean, :default => false, :desc => "My Option"

    # I can later access that option using:
    # options[:my_opt]


    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), '')
    end
  end
end
