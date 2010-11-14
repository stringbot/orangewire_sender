require 'rubygems'
require 'riot'
require 'riot/rr'
require 'ruby-debug'
require 'nokogiri' # TODO how do i just make this a dep for testers but not users

Riot.verbose

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'orangewire_sender'

