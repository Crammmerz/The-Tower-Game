extends Node

@export var spawn_manager: Node
@export var max_waves: int = 20
@export var infitnite: bool = false

var wave_counter: int = 18
var wave_delay: float = 1.0
var kill_count: int = 0
var total_enemies_in_wave: int = 0

var wave_data = { #
	1: {"basic": 5, "unique": 1},
	2: {"basic": 5, "unique": 3},
	3: {"basic": 10, "unique": 6},
	5: {"boss": 1, "unique": 3, "basic": 5}
}

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	GameEvents.game_start.emit()
	GameEvents.enemy_died.connect(_on_enemy_died)
	GameEvents.wave_end.connect(start_wave)
	EntityPoolManager.entity_pool_loaded.connect(start_wave)
	if infitnite: GameEvents.wave_end.connect(increment_wave)

func start_wave():
	if wave_counter >= max_waves:
		GameEvents.all_waves_cleared.emit()
		print("All waves complete!")
		return
	wave_counter += 1
	kill_count = 0
	GameEvents.current_wave = wave_counter
	
	await get_tree().create_timer(wave_delay).timeout
	
	var config = get_wave_config(wave_counter)
	total_enemies_in_wave = 0
	for count in config.values():
		total_enemies_in_wave += count
	
	# 5. Spawn and notify
	print("Starting Wave ", wave_counter, " Spawning ", total_enemies_in_wave, " enemies.")
	_trigger_spawns(config)
	GameEvents.wave_started.emit(wave_counter)

func _trigger_spawns(config: Dictionary):
	if not spawn_manager:
		return

	for i in config.get("basic", 0):
		await get_tree().create_timer(0.1).timeout
		spawn_manager.spawn_basic()
	
	for i in config.get("unique", 0):
		await get_tree().create_timer(0.1).timeout
		spawn_manager.spawn_unique()
		
	for i in config.get("boss", 0):
		await get_tree().create_timer(0.1).timeout
		spawn_manager.spawn_boss()

func get_wave_config(wave_num: int) -> Dictionary:
	return wave_data.get(wave_num, _generate_procedural_wave(wave_num)) 

func _generate_procedural_wave(wave_num: int) -> Dictionary:
	return {
		"basic": min(5 + wave_num * 2, 80),
		"unique": (2 if (wave_num % 3 == 0 or wave_num % 5 == 0) else 0) * randi_range(2, 5),
		"boss": 1 if wave_num % 5 == 0 else 0
	}

func _on_enemy_died(_enemy_node):
	kill_count += 1
	if kill_count >= total_enemies_in_wave:
		GameEvents.wave_end.emit()

func increment_wave(): max_waves += 1
