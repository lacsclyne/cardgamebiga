extends Control

const GameStateScript := preload("res://scripts/core/game_state.gd")
const CardDataScript := preload("res://scripts/data/card_data.gd")

@onready var status_label: Label = $Root/Status
@onready var player_label: Label = $Root/Battlefield/PlayerPanel/PlayerBox/PlayerState
@onready var opponent_label: Label = $Root/Battlefield/EnemyPanel/EnemyBox/EnemyState
@onready var start_button: Button = $Root/Header/StartButton
@onready var hand_container: HBoxContainer = $Root/Hand
@onready var end_turn_button: Button = $Root/ActionRow/EndTurnButton
@onready var log_label: Label = $Root/Log

var game = GameStateScript.new()

func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	end_turn_button.pressed.connect(_on_end_turn_pressed)
	_refresh()

func _on_start_pressed() -> void:
	var starter_deck: Array = _build_starter_deck()
	game.call("start", Time.get_ticks_msec(), starter_deck, [])
	_refresh()

func _on_end_turn_pressed() -> void:
	game.call("end_turn")
	_refresh()

func _on_card_pressed(hand_index: int) -> void:
	game.call("play_card", hand_index)
	_refresh()

func _refresh() -> void:
	status_label.text = _phase_text()
	player_label.text = _player_summary(game.player)
	opponent_label.text = _enemy_summary()
	end_turn_button.disabled = game.phase == GameStateScript.MatchPhase.NOT_STARTED or game.phase == GameStateScript.MatchPhase.FINISHED
	log_label.text = game.last_log
	_refresh_hand()

func _phase_text() -> String:
	match game.phase:
		GameStateScript.MatchPhase.NOT_STARTED:
			return "Ready to start a tiny deckbuilding combat demo."
		GameStateScript.MatchPhase.PLAYER_TURN:
			return "Turn %d: Your turn. Enemy intends to attack for %d." % [game.turn_number, game.enemy_intent_damage]
		GameStateScript.MatchPhase.OPPONENT_TURN:
			return "Enemy turn."
		GameStateScript.MatchPhase.FINISHED:
			return "Match finished. Winner: %s" % game.winner_name
	return "Unknown phase."

func _player_summary(state) -> String:
	if state.name.is_empty():
		return "Waiting for match setup."
	return "%s\nHP: %d/%d\nBlock: %d\nEnergy: %d\nHand: %d\nDeck: %d\nDiscard: %d" % [
		state.name,
		state.health,
		state.max_health,
		state.block,
		state.energy,
		state.hand.size(),
		state.deck.draw_pile.size(),
		state.deck.discard_pile.size()
	]

func _enemy_summary() -> String:
	if game.opponent.name.is_empty():
		return "Waiting for match setup."
	var intent: String = "Attack %d" % game.enemy_intent_damage
	if game.phase == GameStateScript.MatchPhase.FINISHED:
		intent = "Done"
	return "%s\nHP: %d/%d\nBlock: %d\nIntent: %s" % [
		game.opponent.name,
		game.opponent.health,
		game.opponent.max_health,
		game.opponent.block,
		intent
	]

func _refresh_hand() -> void:
	for child in hand_container.get_children():
		hand_container.remove_child(child)
		child.queue_free()

	if game.phase == GameStateScript.MatchPhase.NOT_STARTED:
		_add_empty_hand_label("Press Start Run.")
		return
	if game.player.hand.is_empty():
		_add_empty_hand_label("No cards in hand.")
		return

	for i in range(game.player.hand.size()):
		var card = game.player.hand[i]
		var button = Button.new()
		button.custom_minimum_size = Vector2(150, 108)
		button.text = "%s\nCost %d\n%s\n%s" % [
			card.display_name,
			card.cost,
			card.type_name(),
			card.rules_text
		]
		button.disabled = game.phase != GameStateScript.MatchPhase.PLAYER_TURN or not card.is_playable(game.player.energy)
		button.pressed.connect(_on_card_pressed.bind(i))
		hand_container.add_child(button)

func _add_empty_hand_label(text: String) -> void:
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 18)
	hand_container.add_child(label)

func _build_starter_deck() -> Array:
	var cards: Array = []
	for i in range(5):
		cards.append(_make_card("strike_%d" % i, "Strike", 1, CardDataScript.CardType.ATTACK, 6, 0, "Deal 6 damage."))
	for i in range(5):
		cards.append(_make_card("defend_%d" % i, "Defend", 1, CardDataScript.CardType.SKILL, 0, 5, "Gain 5 block."))
	cards.append(_make_card("bash", "Bash", 2, CardDataScript.CardType.ATTACK, 10, 0, "Deal 10 damage."))
	return cards

func _make_card(id: String, display_name: String, cost: int, card_type: int, damage: int, block: int, rules_text: String):
	var card = CardDataScript.new()
	card.id = StringName(id)
	card.display_name = display_name
	card.cost = cost
	card.card_type = card_type
	card.damage = damage
	card.block = block
	card.rules_text = rules_text
	return card
