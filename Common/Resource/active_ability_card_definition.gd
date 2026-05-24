class_name ActiveAbilityCard extends CardData

@export var ability: AbilityDefinition

func apply_effect():
	var player = GameEvents.player
	if not player: return
	
	var ability_manager = player.get_node("AbilityManager")
	if not ability_manager: return
	
	ability_manager.enable_ability(ability)
