# coding: utf-8
require 'find'
require 'sl'
require 'settings'
require 'os'

module Legendario

  class Crawler

    def crawl
        default_changed = 0
        Find.find(Settings.dir) do |path|
        	leave = false
          if FileTest.directory?(path)
            if File.basename(path)[0] == ?.
              Find.prune       # Don't look any further into this directory.
            else
              next
            end
          else
            if /\.mkv$|\.mp4$|\.avi$/i =~ path
        		    Settings.langs.each do |lang|
                  Sl.info "Downloading #{File.basename(path)} on #{lang}"
                  Os.download_subs(path)
                end
                Settings.langs.each do |lang|
                  Os.delete_video_default_subtitle(path) if Os.check_for_sub(path, lang)
                  # Will to it just for the 1st time
                  if Os.make_default_subtitle(path, lang)
                    Sl.info "Setting #{File.basename(path)} to #{lang}"
                    default_changed += 1
                    break
                  end
                end
        		end
          end
        end
        Sl.info "#{default_changed} movie's language changed"
    end

  end # class
end # module
