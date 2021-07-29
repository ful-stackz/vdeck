module vdeck

import rand
import rand.util as rand_utils

// Creates a deck from the provided set of cards.
pub fn create_deck<T>(cards []T) Deck<T> {
	return Deck<T>{
		cards: cards
	}
}

// Creates a deck of 52 cards (2 through 10, Jock, Queen, King and Ace)
// of the 4 standard suits - Clubs, Diamonds, Hearts and Spades.
pub fn create_standard_deck() Deck<Card> {
	mut cards := []Card{cap: 52}
	// add cards 2-10
	for i in 2 .. 11 {
		cards << [
			Card{
				rank: i
				suit: .diamond
			},
			Card{
				rank: i
				suit: .club
			},
			Card{
				rank: i
				suit: .heart
			},
			Card{
				rank: i
				suit: .spade
			},
		]
	}
	// add jacks, queens, kings and aces
	for suit in [Suit.diamond, Suit.club, Suit.heart, Suit.spade] {
		cards << [
			Card{
				rank: 'jack'
				suit: suit
			},
			Card{
				rank: 'queen'
				suit: suit
			},
			Card{
				rank: 'king'
				suit: suit
			},
			Card{
				rank: 'ace'
				suit: suit
			},
		]
	}
	return create_deck(cards)
}

pub enum Suit {
	@none
	diamond // ♦
	club // ♣
	heart // ♥
	spade // ♠
}

type CardRank = int | string

// Represents a standard playing card with a rank and a suit.
pub struct Card {
	suit Suit
	rank CardRank
}

// Represents a deck of cards.
pub struct Deck<T> {
mut:
	cards []T
}

// Shuffles the deck. Optionally specify how many times to shuffle it.
// `deck.shuffle()` - shuffles the deck once.
// `deck.shuffle(3)` - shuffles the deck 3 times.
pub fn (mut deck Deck<T>) shuffle(times ...int) {
	shuffle_times := if times.len > 0 && times.first() >= 0 { times.first() } else { 1 }
	for _ in 0 .. shuffle_times {
		rand_utils.shuffle(mut deck.cards, 0)
	}
}

// Peeks the card at the top of the deck.
// Does not draw/remove the card from the deck.
pub fn (deck Deck<T>) peek() T {
	if deck.cards.len == 0 {
		panic('There are no cards in the deck.')
	}
	return deck.cards.first()
}

// Peeks a specified amount of cards from the top of the deck.
// Does not draw/remove the cards from the deck.
pub fn (deck Deck<T>) peekn(amount int) []T {
	if deck.cards.len < amount {
		panic('There are not enough cards in the deck.')
	}
	return deck.cards[..amount]
}

// Peeks the card at the middle of the deck.
// Does not draw/remove the card from the deck.
pub fn (deck Deck<T>) peek_middle() T {
	if deck.cards.len == 0 {
		panic('deck.peek_middle: there are no cards in the deck')
	}
	return deck.cards[int(deck.cards.len / 2)]
}

// Peeks the card at the bottom of the deck.
// Does not draw/remove the card from the deck.
pub fn (deck Deck<T>) peek_bottom() T {
	if deck.cards.len == 0 {
		panic('There are no cards in the deck.')
	}
	return deck.cards.last()
}

// Peeks a specified amount of cards from the bottom of the deck.
// Does not draw/remove the cards from the deck.
pub fn (deck Deck<T>) peek_bottomn(amount int) []T {
	if deck.cards.len < amount {
		panic('There are not enough cards in the deck.')
	}
	return deck.cards[(deck.cards.len - amount)..(deck.cards.len)]
}

// Peeks a card from a random position in the deck.
// Does not draw/remove the card from the deck.
pub fn (deck Deck<T>) peek_random() T {
	if deck.cards.len == 0 {
		panic('There are no cards in the deck.')
	}
	return deck.cards[rand.intn(deck.cards.len)]
}

// Peeks a specified amount of cards from random, non-repeating positions in the deck.
// Does not draw/remove the cards from the deck.
pub fn (deck Deck<T>) peek_randomn(amount int) []T {
	if deck.cards.len < amount {
		panic('There are not enough cards in the deck.')
	}
	return rand_utils.sample_nr(deck.cards, amount)
}

// Peeks the card at the specified position in the deck.
// Does not draw/remove the card from the deck.
pub fn (deck Deck<T>) peek_at(position int) T {
	if position < 0 || position > deck.cards.len {
		panic('deck.draw_at: position is out of range (position = $position, 0 <= position < $deck.cards.len)')
	}
	return deck.cards[position]
}

// Draws a card from the top of the deck.
// The card is then removed from the deck.
pub fn (mut deck Deck<T>) draw() T {
	if deck.cards.len == 0 {
		panic('There are no cards in the deck.')
	}
	card := deck.cards.first()
	deck.cards.delete(0)
	return card
}

// Draws a specified amount of cards from the top of the deck.
// The cards are then removed from the deck.
pub fn (mut deck Deck<T>) drawn(amount int) []T {
	if deck.cards.len < amount {
		panic('There are not enough cards in the deck.')
	}
	cards := deck.cards[..amount]
	deck.cards.delete_many(0, amount)
	return cards
}

// Draws the card at the middle of the deck.
// The card is then removed from the deck.
pub fn (mut deck Deck<T>) draw_middle() T {
	if deck.cards.len == 0 {
		panic('deck.draw_middle: there are no cards in the deck')
	}
	card := deck.cards[deck.cards.len / 2]
	deck.cards.delete(deck.cards.len / 2)
	return card
}

// Draws a single cards from the bottom of the deck.
// The card is then removed from the deck.
pub fn (mut deck Deck<T>) draw_bottom() T {
	if deck.cards.len == 0 {
		panic('There are no cards in the deck.')
	}
	return deck.cards.pop()
}

// Draws a specified amount of cards from the bottom of the deck.
// The cards are then removed from the deck.
pub fn (mut deck Deck<T>) draw_bottomn(amount int) []T {
	if deck.cards.len < amount {
		panic('There are not enough cards in the deck.')
	}
	cards := deck.cards[(deck.cards.len - amount)..(deck.cards.len)]
	deck.cards.delete_many(deck.cards.len - amount, amount)
	return cards
}

// Draws a card from a random position in the deck.
// The card is then removed from the deck.
pub fn (mut deck Deck<T>) draw_random() T {
	if deck.cards.len == 0 {
		panic('There are no cards in the deck.')
	}
	position := rand.intn(deck.cards.len)
	card := deck.cards[position]
	deck.cards.delete(position)
	return card
}

// Draws a specified amount of cards from random positions in the deck.
// The cards are then removed from the deck.
pub fn (mut deck Deck<T>) draw_randomn(amount int) []T {
	if deck.cards.len < amount {
		panic('There are not enough cards in the deck.')
	}
	mut indices := rand_utils.sample_nr(sequence(0, deck.cards.len), amount)
	indices.sort(a > b)
	mut cards := []Card{cap: amount}
	for i in indices {
		cards << deck.cards[i]
		deck.cards.delete(i)
	}
	return cards
}

// Draws the card from the specified position in the deck.
// The card is then removed from the deck.
pub fn (mut deck Deck<T>) draw_at(position int) T {
	if position < 0 || position > deck.cards.len {
		panic('deck.draw_at: position is out of range (position = $position, 0 <= position < $deck.cards.len)')
	}
	card := deck.cards[position]
	deck.cards.delete(position)
	return card
}

// Adds the specified card to the top of the deck.
pub fn (mut deck Deck<T>) add(card T) {
	deck.cards.insert(0, card)
}

// Adds the specified card to the middle of the deck.
pub fn (mut deck Deck<T>) add_middle(card T) {
	deck.cards.insert(deck.cards.len / 2, card)
}

// Adds the specified card to the bottom of the deck.
pub fn (mut deck Deck<T>) add_bottom(card T) {
	deck.cards << card
}

// Adds the specified card at the specified position in the deck.
pub fn (mut deck Deck<T>) add_at(position int, card T) {
	if position < 0 || position > deck.cards.len {
		panic('deck.add_at: position out of range (position = $position, 0 <= position <= $deck.cards.len)')
	}
	deck.cards.insert(position, card)
}

// Adds the specified card at a random position in the deck.
pub fn (mut deck Deck<T>) add_random(card T) {
	deck.cards.insert(rand.intn(deck.cards.len), card)
}

// Returns the cards currently in the deck.
pub fn (deck Deck<T>) get_cards() []T {
	return deck.cards
}

// Returns the current amount of cards in the deck.
pub fn (deck Deck<T>) count_cards() int {
	return deck.cards.len
}

// Returns a boolean indicating whether there is atleast 1 card in the deck.
pub fn (deck Deck<T>) has_cards() bool {
	return deck.cards.len != 0
}

// Checks whether the specified card is contained in the deck.
pub fn (deck Deck<T>) contains(card T) bool {
	return deck.cards.any(it == card)
}

// Returns the index of the specified card in the deck.
// Returns `-1` if the card is not contained in the deck.
pub fn (deck Deck<T>) index_of(card T) int {
	if deck.cards.len == 0 {
		return -1
	}
	for index, deck_card in deck.cards {
		if deck_card == card {
			return index
		}
	}
	return -1
}

fn sequence(from int, to int) []int {
	if to < from {
		panic('sequence: @from must be less than or equal to @to')
	}
	mut seq := []int{cap: to - from}
	mut i := from
	for i < to {
		seq << i
		i += 1
	}
	return seq
}
