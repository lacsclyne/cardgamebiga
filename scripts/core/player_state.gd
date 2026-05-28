class_name PlayerState
extends RefCounted

const STARTING_HEALTH := 30
const STARTING_ENERGY := 3
const MAX_HAND_SIZE := 10

var name: String = ""
var health: int = STARTING_HEALTH
var energy: int = STARTING_ENERGY
var hand: Array[CardData] = []
var deck := Deck.new()

func setup(player_name: String, cards: Array[CardData], rng: RandomNumberGenerator) -> void:
	name = player_name
	health = STARTING_HEALTH
	energy = STARTING_ENERGY
	hand.clear()
	deck.setup(cards, rng)

func begin_turn(draw_count: int, energy_per_turn: int, rng: RandomNumberGenerator) -> void:
	energy = energy_per_turn
	draw_cards(draw_count, rng)

func draw_cards(count: int, rng: RandomNumberGenerator) -> void:
	var open_slots := max(MAX_HAND_SIZE - hand.size(), 0)
	hand.append_array(deck.draw(min(count, open_slots), rng))

func discard_hand() -> void:
	deck.discard(hand)
	hand.clear()

func take_damage(amount: int) -> void:
	health = max(health - amount, 0)

func is_defeated() -> bool:
	return health <= 0
