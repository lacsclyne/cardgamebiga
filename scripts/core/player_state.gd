class_name PlayerState
extends RefCounted

const STARTING_HEALTH := 30
const STARTING_ENERGY := 3
const MAX_HAND_SIZE := 10

var name: String = ""
var max_health: int = STARTING_HEALTH
var health: int = STARTING_HEALTH
var energy: int = STARTING_ENERGY
var block: int = 0
var hand: Array[CardData] = []
var deck := Deck.new()

func setup(player_name: String, cards: Array[CardData], rng: RandomNumberGenerator, starting_health: int = STARTING_HEALTH) -> void:
	name = player_name
	max_health = starting_health
	health = starting_health
	energy = STARTING_ENERGY
	block = 0
	hand.clear()
	deck.setup(cards, rng)

func begin_turn(draw_count: int, energy_per_turn: int, rng: RandomNumberGenerator) -> void:
	energy = energy_per_turn
	block = 0
	draw_cards(draw_count, rng)

func draw_cards(count: int, rng: RandomNumberGenerator) -> void:
	var open_slots := max(MAX_HAND_SIZE - hand.size(), 0)
	hand.append_array(deck.draw(min(count, open_slots), rng))

func discard_hand() -> void:
	deck.discard(hand)
	hand.clear()

func gain_block(amount: int) -> void:
	block += max(amount, 0)

func take_damage(amount: int) -> void:
	var incoming := max(amount, 0)
	var blocked := min(block, incoming)
	block -= blocked
	health = max(health - (incoming - blocked), 0)

func is_defeated() -> bool:
	return health <= 0
