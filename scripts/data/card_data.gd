class_name CardData
extends Resource

enum CardType {
	ATTACK,
	SKILL,
	POWER
}

@export var id: StringName
@export var display_name: String = ""
@export var cost: int = 0
@export var card_type: CardType = CardType.ATTACK
@export var damage: int = 0
@export var block: int = 0
@export_multiline var rules_text: String = ""

func is_playable(available_energy: int) -> bool:
	return cost <= available_energy

func type_name() -> String:
	match card_type:
		CardType.ATTACK:
			return "Attack"
		CardType.SKILL:
			return "Skill"
		CardType.POWER:
			return "Power"
	return "Card"
