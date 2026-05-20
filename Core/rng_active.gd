extends Node

func _ready() -> void:
	GameEvents.game_start.connect(open_selection_screen)
	GameEvents.player_leveled_up.connect(open_selection_screen)

func open_selection_screen(level: int = 0):
	get_tree().paused = true
	get_tree().paused = false
