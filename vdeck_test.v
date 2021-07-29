module vdeck

fn test_peek() {
	mut deck := create_standard_deck()
	assert deck.has_cards()
	assert deck.count_cards() == 52

	_ := deck.peek()
	assert deck.count_cards() == 52

	_ := deck.peekn(2)
	assert deck.count_cards() == 52

	_ := deck.peek_bottom()
	assert deck.count_cards() == 52

	_ := deck.peek_bottomn(2)
	assert deck.count_cards() == 52

	_ := deck.peek_random()
	assert deck.count_cards() == 52

	_ := deck.peek_randomn(2)
	assert deck.count_cards() == 52

	_ := deck.peek_middle()
	assert deck.count_cards() == 52
}

fn test_draw() {
	mut deck := create_standard_deck()
	assert deck.has_cards()

	draw := deck.draw()
	assert deck.contains(draw) == false

	drawn := deck.drawn(2)
	assert deck.contains(drawn[0]) == false
	assert deck.contains(drawn[1]) == false

	draw_bottom := deck.draw_bottom()
	assert deck.contains(draw_bottom) == false

	draw_bottomn := deck.draw_bottomn(2)
	assert deck.contains(draw_bottomn[0]) == false
	assert deck.contains(draw_bottomn[1]) == false

	draw_random := deck.draw_random()
	assert deck.contains(draw_random) == false

	draw_randomn := deck.draw_randomn(2)
	assert deck.contains(draw_randomn[0]) == false
	assert deck.contains(draw_randomn[1]) == false

	draw_middle := deck.draw_middle()
	assert deck.contains(draw_middle) == false
}

fn test_add() {
	mut deck := create_standard_deck()
	assert deck.has_cards()
	card1 := Card{
		rank: 'joker'
		suit: .@none
	}

	deck.add(card1)
	assert deck.peek() == card1
	assert deck.draw() == card1

	deck.add_bottom(card1)
	assert deck.peek_bottom() == card1
	assert deck.draw_bottom() == card1

	deck.add_at(5, card1)
	assert deck.peek_at(5) == card1
	assert deck.draw_at(5) == card1

	deck.add_random(card1)
	assert deck.contains(card1)
	assert deck.draw_at(deck.index_of(card1)) == card1

	deck.add_middle(card1)
	assert deck.peek_middle() == card1
	assert deck.draw_middle() == card1
}
