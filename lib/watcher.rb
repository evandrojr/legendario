# coding: utf-8
require 'file-monitor'
require 'find'
require 'sl'
require 'settings'
require 'os'

module Legendario

  class Watcher

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
            if File.exist?(file)
              Sl.info file
						  Os.download_subs(file)
            end
			    end
			  end
  		end
  	end

  end # class
end # module
