extends Node

@export_category("Enemy Categories")
@export var basic: Array[PackedScene] = []
@export var unique: Array[PackedScene] = []
@export var boss: Array[PackedScene] = []

func _ready() -> void:
	for entity in basic:
		EntityPoolManager.initialize_pool(entity, 40)
	for entity in unique:
		EntityPoolManager.initialize_pool(entity, 10)
	for entity in boss:
		EntityPoolManager.initialize_pool(entity, 2)
	
	await get_tree().create_timer(1.0).timeout
	EntityPoolManager.entity_pool_loaded.emit()
	GameEvents.loading_complete.emit()
