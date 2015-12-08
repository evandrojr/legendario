require 'spec_helper'

include FileUtils

describe Settings do

  before :each do
    @default_sub = "/tmp/amovie.srt"
    @specific_sub = "/tmp/amovie.por.srt"
    @movie = "/tmp/amovie.avi"
    rm(@default_sub) if File.exist?(@default_sub)
  end

  it 'deletes default subtitle of a movie file' do
    touch(@default_sub)
    Os.delete_video_default_subtitle(@movie)
    expect(File.exist?(@default_sub)).to eq(false)
  end

  it 'evals the default subtible of a movie' do
    expect(Os.default_movie_subtitle("/anypath/will/do/amorzinha.mp4")).to eq("/anypath/will/do/amorzinha.srt")
  end

  it 'uses a specific subtitle as the default subtitle' do
    touch(@movie)
    touch(@specific_sub)
    expect(Os.make_default_subtitle(@movie, "por")).to eq(true)
    expect(File.exist?(@default_sub)).to eq(true)
  end

end
