extends RefCounted

const GameState := preload("res://scripts/core/game_state.gd")
const CardData := preload("res://scripts/data/card_data.gd")

func test_start_sets_player_turn() -> void:
	var game := GameState.new()
	game.start(1, _deck(), _deck())
	assert(game.phase == GameState.MatchPhase.PLAYER_TURN)
	assert(game.turn_number == 1)
	assert(game.player.hand.size() == 5)

func test_damage_can_finish_match() -> void:
	var game := GameState.new()
	game.start(1, _deck(), _deck())
	game.deal_damage_to_opponent(99)
	assert(game.phase == GameState.MatchPhase.FINISHED)
	assert(game.winner_name == "Ironclad")

func test_playing_card_spends_energy_and_deals_damage() -> void:
	var game := GameState.new()
	game.start(1, _deck(), _deck())
	var enemy_health := game.opponent.health
	assert(game.play_card(0))
	assert(game.player.energy == 2)
	assert(game.opponent.health == enemy_health - 6)

func _deck() -> Array[CardData]:
	var cards: Array[CardData] = []
	for i in range(5):
		var card := CardData.new()
		card.id = "test_%d" % i
		card.display_name = "Test"
		card.cost = 1
		card.damage = 6
		cards.append(card)
	return cards
