extends Node

@export var spawn_manager: Node # You MUST link your SpawnManager here in the Inspector 
@export var max_waves: int = 20

var wave_counter: int = 0
var wave_delay: float = 3.0
var kill_count: int = 0
var total_enemies_in_wave: int = 0 # Track how many enemies need to die 

var wave_data = {
	1: {"basic": 5},
	2: {"basic": 8, "unique": 2},
	3: {"basic": 12, "unique": 4},
	5: {"boss": 1, "basic": 10}
}

func _ready() -> void:
	GameEvents.enemy_died.connect(_on_enemy_died)
	GameEvents.wave_end.connect(start_wave)
	EntityPoolManager.entity_pool_loaded.connect(start_wave)

func start_wave():
	if wave_counter < max_waves:
		wave_counter += 1
		kill_count = 0
		GameEvents.current_wave = wave_counter
		
		var config = get_wave_config(wave_counter)
		
		total_enemies_in_wave = 0
		for count in config.values():
			total_enemies_in_wave += count
		
		_trigger_spawns(config)
		
		GameEvents.wave_started.emit(wave_counter)
	else:
		GameEvents.all_waves_cleared.emit()

func _trigger_spawns(config: Dictionary):
	if not spawn_manager:
		return

	for i in config.get("basic", 0):
		spawn_manager.spawn_basic()
	
	for i in config.get("unique", 0):
		spawn_manager.spawn_unique()
		
	for i in config.get("boss", 0):
		spawn_manager.spawn_boss()

func get_wave_config(wave_num: int) -> Dictionary:
	return wave_data.get(wave_num, _generate_procedural_wave(wave_num)) 

func _generate_procedural_wave(wave_num: int) -> Dictionary:
	return {
		"basic": 5 + wave_num * 2,
		"unique": 1 if wave_num % 3 == 0 else 0
	}

func _on_enemy_died(_enemy_node):
	kill_count += 1
	if kill_count >= total_enemies_in_wave:
		GameEvents.wave_end.emit()
