class_name GameState
extends RefCounted

enum MatchPhase {
	NOT_STARTED,
	PLAYER_TURN,
	OPPONENT_TURN,
	FINISHED
}

const DEFAULT_DRAW_PER_TURN := 1
const DEFAULT_ENERGY_PER_TURN := 3

var rng := RandomNumberGenerator.new()
var player := PlayerState.new()
var opponent := PlayerState.new()
var phase: MatchPhase = MatchPhase.NOT_STARTED
var turn_number: int = 0
var winner_name: String = ""

func start(seed_value: int, player_deck: Array[CardData], opponent_deck: Array[CardData]) -> void:
	rng.seed = seed_value
	player.setup("Player", player_deck, rng)
	opponent.setup("Opponent", opponent_deck, rng)
	turn_number = 1
	winner_name = ""
	phase = MatchPhase.PLAYER_TURN
	player.begin_turn(DEFAULT_DRAW_PER_TURN, DEFAULT_ENERGY_PER_TURN, rng)

func end_turn() -> void:
	if phase == MatchPhase.PLAYER_TURN:
		player.discard_hand()
		phase = MatchPhase.OPPONENT_TURN
		opponent.begin_turn(DEFAULT_DRAW_PER_TURN, DEFAULT_ENERGY_PER_TURN, rng)
	elif phase == MatchPhase.OPPONENT_TURN:
		opponent.discard_hand()
		turn_number += 1
		phase = MatchPhase.PLAYER_TURN
		player.begin_turn(DEFAULT_DRAW_PER_TURN, DEFAULT_ENERGY_PER_TURN, rng)

func deal_damage_to_opponent(amount: int) -> void:
	opponent.take_damage(amount)
	_check_winner()

func deal_damage_to_player(amount: int) -> void:
	player.take_damage(amount)
	_check_winner()

func _check_winner() -> void:
	if player.is_defeated():
		winner_name = opponent.name
		phase = MatchPhase.FINISHED
	elif opponent.is_defeated():
		winner_name = player.name
		phase = MatchPhase.FINISHED
