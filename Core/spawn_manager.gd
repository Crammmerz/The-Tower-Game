extends Node

@export var entity_manager: Node
@export var min_spawn_distance: float = 400.0
@export var max_spawn_distance: float = 700.0

func _ready() -> void:
	EntityPoolManager.entity_pool_loaded.connect(_on_pools_ready)

func _on_pools_ready() -> void:
	pass

func _get_random_spawn_position() -> Vector2:
	var player = GameEvents.player
	if not player:
		return Vector2.ZERO
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	var random_distance = randf_range(min_spawn_distance, max_spawn_distance)
	
	return player.global_position + (random_direction * random_distance)

func _spawn_enemy_from_list(list: Array[PackedScene]) -> void:
	if entity_manager and list.size() > 0:
		var random_scene = list.pick_random()
		
		var enemy = EntityPoolManager.get_from_pool(random_scene)
		
		if enemy:
			var spawn_loc = _get_random_spawn_position()
			enemy.activate(spawn_loc)

func spawn_basic() -> void:
	_spawn_enemy_from_list(entity_manager.basic)

func spawn_unique() -> void:
	_spawn_enemy_from_list(entity_manager.unique)

func spawn_boss() -> void:
	_spawn_enemy_from_list(entity_manager.boss)
