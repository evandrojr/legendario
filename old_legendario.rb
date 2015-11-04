#!/usr/bin/env ruby
require 'find'

d = "/home/j/Downloads"
lang=[]
lang=["eng", "por", "spa", "ger"]
lang.each do |l|
	puts "Language: #{l}"
	c = "getsub -aLl #{l} #{d}"
	puts c
	o = `#{c}`
	puts o
	r = $?.to_i
	puts r
end

total_size = 0
total_files = 0

Find.find(d) do |path|
  if FileTest.directory?(path)
    if File.basename(path)[0] == ?.
      Find.prune       # Don't look any further into this directory.
    else
      next
    end
  else
		if FileTest.symlink?(path)
			c = "rm \"#{path}\""
			puts c
			o = `#{c}`
			puts o
			r = $?.to_i
			puts r
		end
		lang.each do |l|
			if /\.#{l}\.srt$/i =~ File.basename(path)
				puts path
				link = path.sub(/\.#{l}\.srt$/i, '.srt')
				puts link
				c = "ln -s \"#{path}\" \"#{link}\""
				puts c
				o = `#{c}`
				puts o
				r = $?.to_i
				puts r
	    	total_files +=1
	   		total_size += FileTest.size(path)
				break
	    end
		end
  end
end

puts "Total of files linked: #{total_files} Total of file size of linked files: #{total_size}"
