#!/usr/bin/env ruby
require 'uri'

lintOutput = `git diff origin/master --name-only | grep '\.swift' | xargs -I _path swiftlint --path "./_path" `

output = Hash.new
lintOutput.each_line do |line|
    splited = line.split(":")
    filepath =  splited.first
    splited.shift

    file = URI(URI.encode(filepath)).path.split("/").last
    
    value = output[file]
    
    if value.nil?
        value = Array.new
    end

    value.push(splited.join(":"))
    output[file] = value

end

puts "linted #{output.count} files"
output.each {|key, value|
puts "Found #{value.count} in file: #{key}:"
 puts value
 puts "\n\n\n"
}


