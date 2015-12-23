class Os

  class << self
    include FileUtils

    def default_movie_subtitle(path)
      path.sub(/#{File.extname(path)}$/i, '.srt')
    end

    # Receives the path of a movie file and deletes its subtitle
    def delete_video_default_subtitle(path)
      subtitle_file = default_movie_subtitle(path)
      rm(subtitle_file) if File.exist?(subtitle_file)
    end

    def make_default_subtitle(path, lang)
      # path = /tmp/a.avi
      # lang = por
      # /tmp/a.por.srt
      default_sub = default_movie_subtitle(path)
      specific_sub = path.sub(/#{File.extname(path)}$/i, ".#{lang}.srt")
      if File.exist?(specific_sub) and !File.exist?(default_sub)
        Sl.info "cp #{File.basename(specific_sub)} to #{File.basename(default_sub)}"
        cp specific_sub, default_sub
        return true
      end
      false
    end

    def check_for_sub(path, lang)
      File.exist?(path.sub(/#{File.extname(path)}$/i, ".#{lang}.srt"))
    end

    def download_subs(file)
      delete_video_default_subtitle(file)
  		Settings.langs.each do |lang|
  			Sl.info "Language: #{lang}"
  			se("getsub -s hinp -aLl #{lang} \"#{file}\"")
        # Will to it just for the 1st time
        make_default_subtitle(file, lang)
  		end
  	end


    # Shell execute
    def se(command)
  			o = `#{command}`
  			r = $?.to_i
  			Sl.debug "#{o} #{r}"
  			r
  	end

  end

end
