extends Node

signal entity_pool_loaded()

var pools: Dictionary = {}

func _ready() -> void:
	entity_pool_loaded.connect(_on_load)
	GameEvents.player_died.connect(clear_pools)

func _on_load():
	print("Entity Loaded")

func initialize_pool(entity: PackedScene, size: int):
	if pools.has(entity): return
	var new_pool: Array[Node2D] = []
	
	for i in range(size):
		var inst = entity.instantiate()
		inst.visible = false
		inst.set_process(false)
		add_child(inst)
		new_pool.append(inst)
	pools[entity] = new_pool

func get_from_pool(entity: PackedScene):
	if not pools.has(entity): return null
	for obj in pools[entity]:
		if not obj.visible:
			return obj
	return null

func clear_pools():
	print("Player died! Purging all object pools from memory...")
	
	for entity_key in pools:
		var current_pool = pools[entity_key]
		for obj in current_pool:
			if is_instance_valid(obj):
				obj.queue_free() # Eases them out of the game world safely
				
	pools.clear() # Empties the tracking dictionary
