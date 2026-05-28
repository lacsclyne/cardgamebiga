class_name Deck
extends RefCounted

var draw_pile: Array[CardData] = []
var discard_pile: Array[CardData] = []

func setup(cards: Array[CardData], rng: RandomNumberGenerator) -> void:
	draw_pile = cards.duplicate()
	discard_pile.clear()
	shuffle(rng)

func shuffle(rng: RandomNumberGenerator) -> void:
	for i in range(draw_pile.size() - 1, 0, -1):
		var j := rng.randi_range(0, i)
		var temp := draw_pile[i]
		draw_pile[i] = draw_pile[j]
		draw_pile[j] = temp

func draw(count: int, rng: RandomNumberGenerator) -> Array[CardData]:
	var drawn: Array[CardData] = []
	for _i in range(count):
		if draw_pile.is_empty():
			_refill_from_discard(rng)
		if draw_pile.is_empty():
			break
		drawn.append(draw_pile.pop_back())
	return drawn

func discard(cards: Array[CardData]) -> void:
	discard_pile.append_array(cards)

func _refill_from_discard(rng: RandomNumberGenerator) -> void:
	if discard_pile.is_empty():
		return
	draw_pile = discard_pile.duplicate()
	discard_pile.clear()
	shuffle(rng)
