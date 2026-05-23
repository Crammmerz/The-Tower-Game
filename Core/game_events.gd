extends Node


signal game_start()
signal game_end()
signal game_completed()

signal wave_started(wave_number: int)
signal wave_end()
signal all_waves_cleared()

signal player_registered(player_node)
signal player_leveled_up(level: int)
signal player_damaged(current_hp, max_hp)
signal player_died()

signal enemy_died(enemy_node)

var player: Node2D = null
var current_wave: int = 0

func register_player(node: Node2D):
	player = node
	player_registered.emit(node)
