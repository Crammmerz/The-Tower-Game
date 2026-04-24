extends Node

@export var ability: Array[AbilityDefinition] = []
@export var test_ability: PackedScene
@export var player: Node2D

var active_ability: Array[AbilityDefinition] = []

var active_target: Node2D = null

func _ready() -> void:
	for skill in ability:
		skill.initialize_pool(self)
	
	enable_ability(test_ability)

func _process(delta: float) -> void:
	for obj in active_ability:
		obj.tick(delta)
		
		if obj.can_activate():
			if not obj.require_target or (obj.require_target and active_target):
				fire_skill(obj)
				obj.activate()

func fire_skill(data: AbilityDefinition):
	var obj = data.get_from_pool()
	if obj:
		if not obj.get_parent():
			get_tree().current_scene.add_child(obj)
		var target_pos = active_target.global_position if active_target else player.global_position
		obj.activate(player, target_pos, data.base_value)

func enable_ability(scene_to_activate: PackedScene):
	for skill in ability:
		if skill.scene == scene_to_activate:
			if not active_ability.has(skill):
				active_ability.append(skill)
			break

func _on_detection_range_nearest_target_signal(nearest_target: Variant) -> void:
	active_target = nearest_target
