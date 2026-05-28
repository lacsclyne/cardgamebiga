extends RefCounted

const GameState := preload("res://scripts/core/game_state.gd")
const CardData := preload("res://scripts/data/card_data.gd")

func test_start_sets_player_turn() -> void:
	var game := GameState.new()
	game.start(1, _deck(), _deck())
	assert(game.phase == GameState.MatchPhase.PLAYER_TURN)
	assert(game.turn_number == 1)
	assert(game.player.hand.size() == 1)

func test_damage_can_finish_match() -> void:
	var game := GameState.new()
	game.start(1, _deck(), _deck())
	game.deal_damage_to_opponent(99)
	assert(game.phase == GameState.MatchPhase.FINISHED)
	assert(game.winner_name == "Player")

func _deck() -> Array[CardData]:
	var cards: Array[CardData] = []
	for i in range(5):
		var card := CardData.new()
		card.id = "test_%d" % i
		card.display_name = "Test"
		cards.append(card)
	return cards
