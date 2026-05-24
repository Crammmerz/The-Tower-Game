extends HBoxContainer

@onready var hp_bar = $HPbar

func _ready() -> void:
	GameEvents.player_damaged.connect(_on_player_damaged)

func _on_player_damaged(current_hp, max_hp) -> void:
	hp_bar.max_value = max_hp
	hp_bar.value = current_hp
