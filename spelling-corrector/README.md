Spelling corrector
==================

My take on Peter Norvig's
[spelling corrector](http://norvig.com/spell-correct.html).

## Usage

First, grab the dataset:

```
$ wget http://norvig.com/big.txt
```

Then take it for a spin in IRB or Pry:

```ruby
> require "./corrector"
> correct "werd"
# => ["were", "word", "herd", "ward", "weed", "weird", "weld", "wert", "wead", "wed"]
> correct "diktionary"
# => ["dictionary", "wiktionary"]
> correct "nosuchword"
# => ["nosuchword"]
```

Not bad for 22 lines of code. On a par with the original Python
implementation, but considering that Ruby has an explicit `end`, it's
actually tigher, clocking at 17 lines proper.
