# jbinto/tvsoup

A fun little project which generates random phrases using Markov chains trained from mixing together 2 popular TV shows.

## Current status

Just this README, for now.

## Vision

You go to https://tvsoup.xyz, pick 2 shows, and click "generate". Perhaps something is already pre-generated for you. You get a short, tweetable tidbit from the two shows.

Think fun stuff, like combining Downton Abbey with The Wire. Or, King of the Hill and Breaking Bad.

## To do 

**Explore**

* Download subtitles for 2 popular shows from shady websites
* Clean subtitles using grep/sed (e.g. get rid of `CHARACTER:` prefixes and things like `[door closes]`)

* Play with `pry` and `marky_markov` to generate some quotes, for a single show.
* Now, try concatenating two shows together, and see how that affects the output.
* See if there are any `marky_markov` knobs we can tweak to get better sounding quotes. (e.g. 2-grams vs 3-grams).

**Build**

* `rails new tvsoup`
* Create `shows` and `quotes` models
* `shows`: id, name, color, shortname
* `quotes`: id, first_show, second_show, quote
* Create rake task to populate quotes (e.g. come up with permutations, `1000.times { Quote.create(...) }`)
* Dead simple rails view, pick shows, get quotes (could even pre-gen combos)

**Polish**

* Style it up a bit. Look into the micro-optimizations below. Or just call it a day, ship **something**.
* Deploy to DigitalOcean. This probably means resurrecting my ansible project.
* Set up domain, cloudflare proxy.

## Caveats, concerns, micro-optimizations, bikeshedding

* I want the whole project to be on github, but I don't want to publish subtitles because that will get the project DMCA'd. (**Solution:** Post a zip file somewhere and download it with a rake task.) 

* KISS would be to just have a rails (/etc) app that directly uses the `marky_markov` dictionary. Perhaps this is good enough, but I'd like to go a little further.

* My gut tells me it would be better for performance/architecture to precompute a bunch of them in a rake task and put them in an ActiveRecord table. Then `marky_markov` isn't being executed from a web request, which feels more correct. But maybe this is a micro-optimization. 

* I could use an (ember?) frontend which downloads a bunch (100?) of quotes at once, e.g. `getQuotes(show1, show2, 100)`. Initial load would take a few 100 ms, but then each generate would be instant.

* Use `localStorage` to save fun quotes.


