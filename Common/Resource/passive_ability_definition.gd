class_name PassiveAbilityCardData extends CardData

@export var ability_scene: PackedScene 

func apply_effect() -> void:
	var player = GameEvents.player
	if player:
		var instance = ability_scene.instantiate()
		instance.activate(player)
