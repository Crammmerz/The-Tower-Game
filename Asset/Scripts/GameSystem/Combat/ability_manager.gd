extends Node

@export var abilities: Array[AbilityDefinition] = []
@export var player: Node2D

var cooldowns: Dictionary = {}
var pools: Dictionary = {}

var active_abilities: Array[AbilityDefinition] = []
var active_target: Node2D = null

func _ready() -> void:
	for data in abilities:
		initialize_pool(data)
	if abilities.size() >= 1: enable_ability(abilities[0])
	if abilities.size() >= 1: enable_ability(abilities[1])

func initialize_pool(data: AbilityDefinition):
	var new_pool: Array[Node2D] = []
	
	for i in range(data.pool_size):
		var inst = data.scene.instantiate()
		inst.visible = false
		inst.set_process(false)
		add_child(inst)
		new_pool.append(inst)
	pools[data] = new_pool
	cooldowns[data] = 0.0

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
	var obj = get_from_pool(data)
	if obj:
		cooldowns[data] = calculate_cooldown(data)
		var target_pos = active_target.global_position if active_target else player.global_position
		obj.activate(target_pos, data)

func get_from_pool(data: AbilityDefinition):
	for obj in pools[data]:
		if not obj.visible:
			return obj
	return null

func calculate_cooldown(data: AbilityDefinition) -> float:
	if data.special_tags.get("ignore_cdr", false):
		return data.cooldown
	return data.cooldown / player.stats.cooldown_reduction

func enable_ability(data: AbilityDefinition):
	if not active_abilities.has(data):
		active_abilities.append(data)

func _on_detection_range_nearest_target_signal(nearest_target: Variant) -> void:
	active_target = nearest_target
