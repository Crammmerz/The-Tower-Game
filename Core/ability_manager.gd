extends Node

var active_target: Node2D = null
var active_abilities: Array[AbilityDefinition] = []
var cooldowns: Dictionary = {}
@export var test: AbilityDefinition

func _ready() -> void:
	enable_ability(test)

func _process(delta: float) -> void:
	for data in active_abilities:
		
		if cooldowns[data] > 0:
			cooldowns[data] -= delta
		
		if cooldowns[data] <= 0:
			var no_target = not data.special_tags.get("require_target", false)
			var has_target = data.special_tags.get("require_target", false) and active_target
			if has_target or no_target:
				fire_skill(data)

func fire_skill(data: AbilityDefinition):
	var player = GameEvents.player
	var obj = AbilityPoolManager.get_from_pool(data)
	if obj:
		cooldowns[data] = calculate_cooldown(data)
		var target_pos = active_target.global_position if active_target else player.global_position
		obj.activate(player, target_pos, data)

func calculate_cooldown(data: AbilityDefinition) -> float:
	var player = GameEvents.player
	if data.special_tags.get("ignore_cdr", false):
		return data.cooldown
	return data.cooldown / player.profile.cd_reduction

func enable_ability(data: AbilityDefinition):
	if not active_abilities.has(data):
		active_abilities.append(data)
		cooldowns[data] = 0.0

func _on_detection_range_nearest_target_signal(nearest_target: Variant) -> void:
	active_target = nearest_target
