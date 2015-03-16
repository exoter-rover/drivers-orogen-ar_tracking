#! /usr/bin/env ruby

require 'orocos'
include Orocos

Orocos.initialize

Orocos.run 'ar_tracking::Task' => 'vicon_driver' do |p|