#!/usr/bin/ruby -w
# -*- coding: UTF-8 -*-

# Author: KayMW

# Copyright © 2017 KayMW <RedL0tus@users.noreply.github.com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the LICENSE file for more details.

require 'sqlite3'

puts "Initializing database..."

if !(File.exist?("database.db"))
  db = SQLite3::Database.new("database.db")
  puts "done"
  db.execute("DROP TABLE IF EXISTS pakreq")
  db.execute("DROP TABLE IF EXISTS users")
  db.execute("CREATE TABLE pakreq(pkgname,description,packager,requester)")
  db.execute("CREATE TABLE users(id,session,subscribe)")
else
  puts "Database exists, skipping..."
end

if (File.exist?("config.yml"))
  print 'Config exists, do you want to replace it? [Y/n] '
  choice = gets.chomp
  if choice != 'Y' and choice != 'y'
    puts "Aborting..."
    exit
  else
    File.delete("config.yml")
  end
end

puts "Creating config file..."

configfile = File.new('config.yml','w+')

if configfile
  configfile.syswrite("bot:\n")
  print 'Please enter token from @BotFather: '
  token = gets.chomp
  configfile.syswrite("  token: #{token} \n")
  print 'Do you want to write log to file? [Y/n] '
  write = gets.chomp
  if write != 'Y' and write != 'y'
    config_write = 'false'
  else
    config_write = 'true'
  end
  configfile.syswrite("  write_log_to_file: #{config_write}")
  configfile.close
else
  puts "Cannot write file, aboring..."
  puts "Do you have permission to write here?"
  exit
end
