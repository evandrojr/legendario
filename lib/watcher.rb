# coding: utf-8
require "legendario/version"
require 'file-monitor'
require 'find'
require 'sl'
require 'settings'

module Legendario

  class Watcher

  	def se(command)
  			o = `#{command}`
  			r = $?.to_i
  			Sl.debug "#{o} #{r}"
  			r
  	end

  	def download_subs(file)
  		Settings.langs.each do |l|
  			Sl.info "Language: #{l}"
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
  				Settings.langs.each do |l|
  					if /\.#{l}\.srt$/i =~ File.basename(path) and !symlinked
  						Sl.debug path
  						link = path.sub(/\.#{l}\.srt$/i, '.srt')
  						Sl.debug link
  						symlinked =  true
  						se("ln -s \"#{path}\" \"#{link}\"")
  						break #this break is not working so using !symlinked
  			    end
  				end
  		  end
  		end
  	end

  	def watch_dirs
  		FileMonitor.watch Settings.dir do
  		  dirs {
  		    disallow /\.git$/
  		  }

  		  files {
  		    disallow /.*/
  		    allow /\.mkv$|\.mp4$|\.avi$/
  		  }
  				exec do |events|
  			    events.each do |ev|
  			      file = File.join(ev.watcher.path(), ev.name())
  						Sl.info file
  						Watcher.new.download_subs(file)
  			    end
  			  end
  		end
  	end

  end
end
