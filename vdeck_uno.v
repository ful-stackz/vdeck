module vdeck

// Creates a standard deck of 108 Uno cards, including
// one `0` of each color, four `1` - `9` of each color,
// four `skip`, `reverse` and `draw two` of each color,
// and four `change color` and `draw four` (each) wild cards.
pub fn create_uno_deck() Deck<UnoCard> {
	mut cards := []UnoCard{cap: 108}

	// add colored cards
	for color in [UnoColor.red, UnoColor.yellow, UnoColor.green, UnoColor.blue] {
		// 1 zero card for each color
		cards << UnoNumberCard{color, 0}

		// cards from 1 through 9 appear twice for each color
		for number in 1 .. 10 {
			cards << UnoNumberCard{color, number}
			cards << UnoNumberCard{color, number}
		}

		// action cards appear twice for each color
		for action in [UnoAction.skip, UnoAction.reverse, UnoAction.draw_two] {
			cards << UnoActionCard{color, action}
			cards << UnoActionCard{color, action}
		}
	}

	// add wild cards
	for action in [UnoWildAction.change_color, UnoWildAction.draw_four] {
		// each wild card appears 4 times
		for _ in 0 .. 4 {
			cards << UnoWildCard{action}
		}
	}

	return create_deck<UnoCard>(cards)
}

pub enum UnoColor {
	red
	yellow
	green
	blue
}

pub enum UnoAction {
	skip
	reverse
	draw_two
}

pub enum UnoWildAction {
	change_color
	draw_four
}

pub struct UnoNumberCard {
	color  UnoColor
	number int
}

pub struct UnoActionCard {
	color  UnoColor
	action UnoAction
}

pub struct UnoWildCard {
	action UnoWildAction
}

pub type UnoCard = UnoActionCard | UnoNumberCard | UnoWildCard
