extends Control

const GameState := preload("res://scripts/core/game_state.gd")
const CardData := preload("res://scripts/data/card_data.gd")

@onready var status_label: Label = $Root/Status
@onready var player_label: Label = $Root/Board/PlayerPanel/PlayerState
@onready var opponent_label: Label = $Root/Board/OpponentPanel/OpponentState
@onready var start_button: Button = $Root/ActionRow/StartButton
@onready var draw_button: Button = $Root/ActionRow/DrawButton
@onready var end_turn_button: Button = $Root/ActionRow/EndTurnButton

var game := GameState.new()

func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	draw_button.pressed.connect(_on_draw_pressed)
	end_turn_button.pressed.connect(_on_end_turn_pressed)
	_refresh()

func _on_start_pressed() -> void:
	var starter_deck := _build_starter_deck()
	game.start(Time.get_unix_time_from_system(), starter_deck, starter_deck)
	_refresh()

func _on_draw_pressed() -> void:
	if game.phase == GameState.MatchPhase.PLAYER_TURN:
		game.player.draw_cards(1, game.rng)
	_refresh()

func _on_end_turn_pressed() -> void:
	game.end_turn()
	_refresh()

func _refresh() -> void:
	status_label.text = _phase_text()
	player_label.text = _player_summary(game.player)
	opponent_label.text = _player_summary(game.opponent)
	draw_button.disabled = game.phase != GameState.MatchPhase.PLAYER_TURN
	end_turn_button.disabled = game.phase == GameState.MatchPhase.NOT_STARTED or game.phase == GameState.MatchPhase.FINISHED

func _phase_text() -> String:
	match game.phase:
		GameState.MatchPhase.NOT_STARTED:
			return "Ready to start a prototype match."
		GameState.MatchPhase.PLAYER_TURN:
			return "Turn %d: Player turn." % game.turn_number
		GameState.MatchPhase.OPPONENT_TURN:
			return "Turn %d: Opponent turn." % game.turn_number
		GameState.MatchPhase.FINISHED:
			return "Match finished. Winner: %s" % game.winner_name
	return "Unknown phase."

func _player_summary(state: PlayerState) -> String:
	if state.name.is_empty():
		return "Waiting for match setup."
	return "%s\nHealth: %d\nEnergy: %d\nHand: %d\nDeck: %d\nDiscard: %d" % [
		state.name,
		state.health,
		state.energy,
		state.hand.size(),
		state.deck.draw_pile.size(),
		state.deck.discard_pile.size()
	]

func _build_starter_deck() -> Array[CardData]:
	var cards: Array[CardData] = []
	for i in range(10):
		var card := CardData.new()
		card.id = "strike_%d" % i
		card.display_name = "Strike"
		card.cost = 1
		card.card_type = CardData.CardType.ATTACK
		card.rules_text = "Deal a small amount of damage."
		cards.append(card)
	return cards
