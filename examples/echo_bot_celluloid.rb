#!/usr/bin/env ruby
# vim:encoding=UTF-8:

$LOAD_PATH << "lib"
$LOAD_PATH << "../lib"

require "rubygems"
require "net/irc"

require "pp"

require 'celluloid/io'

class EchoBot < Net::IRC::Client
  include Celluloid::IO
  def initialize(addr,port,opt)
    opt[:tcp_socket] = Celluloid::IO::TCPSocket
    super
    start
  end

  def on_rpl_welcome(m)
    post JOIN, "#demo"
    super
  end

  def on_privmsg(m)
    post NOTICE, m[0], m[1]
  end
end


supervisor = EchoBot.supervise_as :echo_bot, "188.40.141.208", "6667", {
  :nick => "foo",
  :user => "foo",
  :real => "foobartest",
}

sleep
