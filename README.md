# Cheferize

Cheferize is a Ruby gem which 'translates' strings into Swedish Chef.

## Inspiration / Prior Art

Inspired by encheferizer.php by eamelink (Erik Bakker).

About encheferizer.php

  * http://bork.eamelink.nl (defunct as of 17 Jan 2010)
  * Based on the original chef.x from John Hagerman.
  * More info about the original chef.x : http://tbrowne.best.vwh.net/chef/ (also defunct as of 17 Jan 2010)

## Build Status

[![Test Suite](https://github.com/alexdean/cheferize/actions/workflows/rspec.yml/badge.svg)](https://github.com/alexdean/cheferize/actions/workflows/rspec.yml)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cheferize'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cheferize

## Usage

```
>> class String; include Cheferize; end
>> "This is a test!".to_chef
=> "Tees is e test, bork bork bork!"
```

## License

Cheffereeze-a is free-a sufftvere; yuoo cun redeestriboote-a it und/ur mudeeffy
it under zee terms ooff zee GNU Generel Poobleec Leecense-a es poobleeshed by
zee Free-a Sufftvere-a Fuoondeshun; ieezeer ferseeun 2 ooff zee Leecense, oor
(et yuoor oopshun) uny leter ferseeun.

Cheffereeze-a is deestribooted in zee hupe-a tet it veell be-a useffool,
boot VITOUT UnY VERRUnTY; veetuoot ifee zee impleeed verrunty ooff
MERCHUnTEBILITY oor FITNESS FOR E PERTICULER PURPOSE. See-a zee
GNU Generel Poobleec Leecense-a fur mure-a deteeels.

Yuoo shuoold hefe-a receeefed e cupy ooff zee GNU Generel Poobleec Leecense-a
elung veet Cheffereeze; iff nut, vreete-a tu zee Free-a Sufftvere-a
Fuoondeshun, Inc., 51 Frunkleen St, Feefft Fluur, Bustun, MA 02110-1301 USA

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexdean/cheferize.
