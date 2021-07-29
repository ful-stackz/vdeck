# Generic deck of cards in V

`vdeck` gives you a working, generic implementation for a deck of cards. It comes with a standard Card and Suit types but is open for your specific `Deck<T>`!

`vdeck` allows you to do all the stuff you would with a physical deck of cards:
- add/draw/peek card from the top, middle and bottom
- add/draw/peek card from a specific position
- add/draw/peek card from a random position
- shuffle
- and more

## Samples

### Standard deck of cards

```vlang
import { create_standard_deck } from vdeck

fn main() {
  // it's important that the deck is a mutable variable
  // so that, for example, when drawing cards they are
  // automatically removed from the deck
  mut deck := create_standard_deck()
  deck.shuffle()
}
```

### Custom deck of cards

Say you had a specific or custom deck of cards, worry not, `vdeck` has you covered! All you need to do is define the shapes of the cards and then create a deck consisting of cards of that shape.

The most simplistic custom card would be an integer. This is how you would go about creating a deck of integer cards:

```vlang
import { create_deck } from vdeck

fn main() {
  // specify the shape of the card as the generic type argument
  // specify the deck of cards as the function argument
  // boom! you got yourself a deck of cards!
  mut deck := create_deck<int>([1, 2, 3, 4, 5, 6, 7, 8, 9])
  deck.shuffle(4)
  random_card := deck.draw_random()
}
```

For more customized (and reallistic) decks you can check out how `vdeck` implements the cards needed to play the [Uno game](https://en.wikipedia.org/wiki/Uno_(card_game)) in the `vdeck_uno.v` file.
