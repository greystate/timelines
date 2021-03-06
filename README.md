# Timelines

I saw [this tweet][TWEET] from [Eric Meyer][ERIC] and immediately created a W3C account and requested an API key, so I could create all sorts of timelines from the available specifications (there are _many!_ as I discovered while trying to figure out which endpoint(s) to hit).

The `specifications.xml` file lists the ones you'd like to include, by specifying their *shortname* and a *title* for use in the generated table (couldn't really figure out from Eric's file if I could just take that from one of the versions returned from the API, so for now it's typed in there).

## How to use it

I honestly don't know if anyone else but me would like to try it, but in the event that they will, here's what they (you) need to do:

1. Get a [W3C account][ACC] if you haven't got one
2. Create an [API key][KEY]
3. Paste the key into the `build.sh` (top of file - you can't miss it)
4. Run the `build.sh` script (e.g. with: `sh build.sh` in its directory)
5. Open the generated `timelines.html` file in a web browser

### Credits

This is of course entirely and heavily inspired by Eric Meyer's [CSS Module Timelines][ORIGIN] page, which you should definitely checkout.

## OMG, why didn't you use _&lt;anything else but XSLT&gt;_ for this??

Because :metal: :rocket: and :shipit: !

## TODO

Here's some things I'd like to be able to do at some point:

- [ ] Do some caching so we don't hit the API on every build (one key allows ~5000 request per hour, but still...)
- [ ] Use commandline args for API key and `specifications.xml` file

[TWEET]: https://twitter.com/meyerweb/status/668856592553656321
[ERIC]: https://twitter.com/meyerweb/
[ACC]: https://www.w3.org/accounts/request
[KEY]: https://www.w3.org/users/myprofile/apikeys

[ORIGIN]: http://meyerweb.com/eric/css/timelines