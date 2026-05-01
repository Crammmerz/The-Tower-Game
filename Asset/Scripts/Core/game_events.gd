extends Node

var player: Node2D = null

# Use a signal so skills can "wait" for the player to exist if needed
signal player_registered(player_node)

func register_player(node: Node2D):
	player = node
	player_registered.emit(node)
