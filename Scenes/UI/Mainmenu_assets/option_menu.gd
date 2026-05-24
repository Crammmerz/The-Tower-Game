class_name OptionMenu
extends Control

@onready var exit = $MarginContainer/VBoxContainer/Exit as Button
signal option_exit

func _ready():
	exit.button_down.connect(on_exit_pressed)
	set_process(false)

func on_exit_pressed() -> void:
	option_exit.emit()
	set_process(false)
