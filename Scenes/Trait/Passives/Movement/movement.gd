extends Node

func activate(host: Node2D):
	if host:
		host.set_physics_process(true)
		queue_free()
