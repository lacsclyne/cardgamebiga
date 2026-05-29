class_name GameState
extends RefCounted

const PlayerStateScript := preload("res://scripts/core/player_state.gd")

enum MatchPhase {
	NOT_STARTED,
	PLAYER_TURN,
	OPPONENT_TURN,
	FINISHED
}

const DEFAULT_ENERGY_PER_TURN := 3
const PLAYER_DRAW_PER_TURN := 5
const PLAYER_STARTING_HEALTH := 50
const ENEMY_STARTING_HEALTH := 42
const ENEMY_INTENTS := [6, 8, 10]

var rng := RandomNumberGenerator.new()
var player := PlayerStateScript.new()
var opponent := PlayerStateScript.new()
var phase: MatchPhase = MatchPhase.NOT_STARTED
var turn_number: int = 0
var winner_name: String = ""
var enemy_intent_damage: int = 0
var last_log: String = "Press Start Run to begin."

func start(seed_value: int, player_deck: Array, _opponent_deck: Array = []) -> void:
	rng.seed = seed_value
	player.setup("Ironclad", player_deck, rng, PLAYER_STARTING_HEALTH)
	opponent.setup("Training Cultist", [], rng, ENEMY_STARTING_HEALTH)
	turn_number = 1
	winner_name = ""
	enemy_intent_damage = _next_enemy_intent()
	phase = MatchPhase.PLAYER_TURN
	player.begin_turn(PLAYER_DRAW_PER_TURN, DEFAULT_ENERGY_PER_TURN, rng)
	last_log = "A training fight begins. Play cards, then end your turn."

func end_turn() -> void:
	if phase == MatchPhase.PLAYER_TURN:
		player.discard_hand()
		phase = MatchPhase.OPPONENT_TURN
		_resolve_enemy_turn()
		if phase == MatchPhase.FINISHED:
			return
		turn_number += 1
		enemy_intent_damage = _next_enemy_intent()
		phase = MatchPhase.PLAYER_TURN
		player.begin_turn(PLAYER_DRAW_PER_TURN, DEFAULT_ENERGY_PER_TURN, rng)
		last_log += "\nTurn %d begins. Draw %d cards." % [turn_number, PLAYER_DRAW_PER_TURN]

func play_card(hand_index: int) -> bool:
	if phase != MatchPhase.PLAYER_TURN:
		last_log = "You can only play cards during your turn."
		return false
	if hand_index < 0 or hand_index >= player.hand.size():
		last_log = "That card is no longer in hand."
		return false

	var card = player.hand[hand_index]
	if not card.is_playable(player.energy):
		last_log = "Not enough energy for %s." % card.display_name
		return false

	player.energy -= card.cost
	player.hand.remove_at(hand_index)
	var log_lines := PackedStringArray()

	if card.damage > 0:
		opponent.take_damage(card.damage)
		log_lines.append("%s deals %d damage." % [card.display_name, card.damage])
	if card.block > 0:
		player.gain_block(card.block)
		log_lines.append("%s grants %d block." % [card.display_name, card.block])

	var discarded: Array = []
	discarded.append(card)
	player.deck.discard(discarded)
	last_log = "\n".join(log_lines)
	_check_winner()
	return true

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
		last_log = "Defeat. The enemy wins this demo fight."
	elif opponent.is_defeated():
		winner_name = player.name
		phase = MatchPhase.FINISHED
		last_log = "Victory. The training enemy is defeated."

func _resolve_enemy_turn() -> void:
	player.take_damage(enemy_intent_damage)
	last_log = "Enemy attacks for %d." % enemy_intent_damage
	_check_winner()

func _next_enemy_intent() -> int:
	return ENEMY_INTENTS[(turn_number - 1) % ENEMY_INTENTS.size()]
