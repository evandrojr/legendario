class Settings
  @dir = ""
  @langs = []

  class << self
    attr_accessor :dir, :langs
  end
end
