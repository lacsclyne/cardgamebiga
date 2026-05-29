extends SceneTree

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var scene = load("res://scenes/main.tscn").instantiate()
	root.add_child(scene)
	await process_frame

	_require(scene.game.phase == scene.GameStateScript.MatchPhase.NOT_STARTED, "demo starts idle")

	var start_button = scene.get_node("Root/Header/StartButton")
	start_button.pressed.emit()
	await process_frame

	_require(scene.game.phase == scene.GameStateScript.MatchPhase.PLAYER_TURN, "start enters player turn")
	_require(scene.game.player.hand.size() == 5, "player draws opening hand")
	_require(scene.get_node("Root/Hand").get_child_count() == 5, "hand UI renders five cards")

	var starting_enemy_health: int = scene.game.opponent.health
	var first_card = scene.get_node("Root/Hand").get_child(0)
	first_card.pressed.emit()
	await process_frame

	_require(scene.game.player.energy < 3, "playing a card spends energy")
	_require(scene.game.opponent.health < starting_enemy_health or scene.game.player.block > 0, "playing a card changes combat state")

	scene.get_node("Root/ActionRow/EndTurnButton").pressed.emit()
	await process_frame

	_require(scene.game.phase == scene.GameStateScript.MatchPhase.PLAYER_TURN, "enemy turn resolves back to player")
	_require(scene.game.turn_number == 2, "ending turn advances the turn counter")

	print("E2E smoke passed: start, play card, end turn.")
	quit(0)

func _require(condition: bool, message: String) -> void:
	if condition:
		return
	push_error("E2E smoke failed: %s" % message)
	quit(1)
