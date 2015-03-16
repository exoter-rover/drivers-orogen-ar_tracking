#! /usr/bin/env ruby

require 'orocos'
include Orocos

Orocos.initialize

ENV['PKG_CONFIG_PATH'] = "#{File.expand_path("..", File.dirname(__FILE__))}/build:#{ENV['PKG_CONFIG_PATH']}"

Orocos.run 'ar_tracking::Task' => 'artDriver' do |p|
	driver = p.task 'artDriver'
	Orocos.log_all_ports

	driver.host="127.0.0.1"
	driver.server_port=50105
	driver.data_port=0

	driver.configure
    driver.start

    reader = driver.pose_samples.reader

    loop do
	if sample = reader.read
	    puts "%s %s %s" % [sample.position.data[0], sample.position.data[1], sample.position.data[2]]
	end
	sleep 0.01
    end

    driver.stop
end