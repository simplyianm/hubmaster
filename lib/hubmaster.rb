require 'rubygems'
require 'highline/import'
require 'json'
require 'net/http'
require 'net/https'
require 'stringio'
require 'uri'
require 'openssl'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

require File.expand_path(File.join(File.dirname(__FILE__), "hubmaster", "base.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "hubmaster", "repo.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "hubmaster", "cipher.rb"))

