#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require 'awesome_print'
require 'file-monitor'
require 'find'

lib_dir = File.join File.dirname(__FILE__), '../lib'
$:.unshift lib_dir unless $:.include? lib_dir

class Legendario
	@dir = ""
	def lang
		["eng", "por", "spa", "ger"]
	end

	def self.watch
		Legendario.new.watch_dirs(@dir)
	end

	def se(command)
			puts command
			o = `#{command}`
			r = $?.to_i
			puts "#{o} #{r}"
			r
	end

	def download_subs(file)
		lang().each do |l|
			puts "Language: #{l}"
			se("getsub -aLl #{l} \"#{file}\"")
		end
		symlink(File.dirname(file))
	end

	def symlink(dir)
		Find.find(dir) do |path|
		  if FileTest.directory?(path)
		    if File.basename(path)[0] == ?.
		      Find.prune       # Don't look any further into this directory.
		    else
		      next
		    end
		  else
				if FileTest.symlink?(path)
					se("rm \"#{path}\"")
				end
				symlinked = false
				lang().each do |l|
					if /\.#{l}\.srt$/i =~ File.basename(path) and !symlinked
						puts path
						link = path.sub(/\.#{l}\.srt$/i, '.srt')
						puts link
						symlinked =  true
						se("ln -s \"#{path}\" \"#{link}\"")
						break #this break is not working so using !symlinked
			    end
				end
		  end
		end
	end

	def watch_dirs(dir)
		FileMonitor.watch dir do
		  dirs {
		    disallow /\.git$/
		  }

		  files {
		    disallow /.*/
		    allow /\.mkv$|\.mp4$|\.avi$/
		  }
			begin
				exec do |events|
			    events.each do |ev|
			      file = File.join(ev.watcher.path(), ev.name())
						puts file
						Legendario.new.download_subs(file)
			    end
			  end
				#Avoids breaking after a directory been deleted
				rescue => error
					puts("#{error.class} and #{error.message}")
					Legendario.watch
			end
		end
	end
end

Legendario.watch
