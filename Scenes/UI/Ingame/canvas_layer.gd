extends CanvasLayer

@onready var wave_label = $PanelContainer/HBoxContainer/WaveLabel

func _ready() -> void:
	GameEvents.wave_started.connect(_on_wave_started)
	GameEvents.all_waves_cleared.connect(_on_all_cleared)
	wave_label.text = "0"

func _on_wave_started(wave_num: int) -> void:
	wave_label.text = str(wave_num)

func _on_all_cleared() -> void:
	wave_label.text = "CLEARED!"
