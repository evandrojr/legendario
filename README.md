# [Project moved to: https://github.com/evandrojr/layback](https://github.com/evandrojr/layback)

# Please use that one.

<p>If you like this, why not buy me a beer: <a rel="nofollow" href="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=evandrojr%40gmail%2ecom&lc=US&item_name=evandro%2eorg&currency_code=USD&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHosted"><img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif" alt="Donate"></a><br>
<br></p>

# Legendario RubyGem

[![Build Status](https://secure.travis-ci.org/evandrojr/legendario.png)](http://travis-ci.org/evandrojr/legendario)
[![Gem Version](https://badge.fury.io/rb/legendario.svg)](https://badge.fury.io/rb/legendario)

After dectecting a movie has been downloaded `Legendario` will search and download its subtitles automatically.

## Installation

I don't know the reason for it, but installing the gem using sudo it not working. So I recommend you install RVM or rbenv in advance and then install legendario with a non privileved user like yourself.

see [RVM installtion](https://rvm.io/rvm/install)

or [rbenv](https://github.com/rbenv/rbenv)

Then install Legendario yourself as:

    $ gem install legendario


## Tools

There are 3 tools at the moment:

    crawl4subs: Will download the subtitles of the movies
    inside a parent folder recursively.

    watch4subs: Watches a folder for new movies and downloads the subtitles as soon 
    as the movie finishes downloading.

    lang4subs: Change the default language of
    all the movies in a parent folder recursively.


In case you are a polyglot you can pass as many languages as you like as parameters. The first language available for the movie will be set as the default language for the movie.

## Usage

### Download subtitles in English and Portuguese for all the movies  

    $ crawl4subs "folder-with-movies" pob eng por

for example.

Default languages are: eng por spa ger on this sequence of priority. [Sub language ISO 639-2](https://github.com/byroot/ruby-osdb/blob/master/lib/osdb/language.rb) code like pob (Brazilian Portuguese), fre or eng.

### Lay back and let watch4subs do all the work for you. As soon a new movie arrives it will download the subtitles for it.  

Edit your rc.local file to start watch4subs after boot

    su (username) -lc "watch4subs folder-with-movies subs-langs"  

Example
`su evandro -lc "watch4subs ~/Downloads pob por spa"`


### Change the languages of the subtitles

    $ lang4subs "folder-with-movies" spa por


Bug reports and pull requests are welcome on GitHub at https://github.com/evandrojr/legendario. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Thanks

### Subtitles service powered by www.OpenSubtitles.org
