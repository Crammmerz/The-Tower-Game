extends Node

@export var card_pool_manager: Node

func _ready() -> void:
	GameEvents.player_leveled_up.connect(test)

func test():
	pass
