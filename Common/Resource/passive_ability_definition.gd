class_name PassiveAbilityCard extends CardData

@export var ability_scene: PackedScene 

func apply_effect() -> void:
	var player = GameEvents.player
	if player:
		var instance = ability_scene.instantiate()
		player.add_child(instance)
		instance.activate()
