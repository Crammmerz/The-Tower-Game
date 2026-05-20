extends Node

signal ability_pool_loaded()

var pools: Dictionary = {}

func initialize_pool(data: AbilityDefinition):
	if pools.has(data): return
	
	pools[data] = []
	var count = data.pool_size
	var index = 0
	
	var timer = Timer.new()
	timer.wait_time = 0.001 # 10ms per batch
	timer.one_shot = false
	add_child(timer)
	
	timer.connect("timeout", Callable(self, "_on_pool_tick").bind(data, count, index, timer))
	timer.start()

func _on_pool_tick(data: AbilityDefinition, count: int, index: int, timer: Timer):
	var inst = data.scene.instantiate()
	inst.visible = false
	inst.set_process(false)
	add_child(inst)
	pools[data].append(inst)
	index += 1
	if index >= count:
		timer.stop()
		timer.queue_free()
		emit_signal("ability_pool_loaded")

func get_from_pool(data: AbilityDefinition):
	if not pools.has(data): initialize_pool(data)
	
	for obj in pools[data]:
		if not obj.visible:
			return obj
	return null
