class_name MainMenu
extends Control

@onready var start_button = $"MarginContainer/HBoxContainer/VBoxContainer/Start game" as Button
@onready var option = $"MarginContainer/HBoxContainer/VBoxContainer/Option" as Button
@onready var exit = $"MarginContainer/HBoxContainer/VBoxContainer/Exit" as Button
@onready var option_menu = $option_menu as OptionMenu
@onready var margin_container = $MarginContainer as MarginContainer

@export var slime_world = preload("res://Scenes/Game World/SlimeStage.tscn") as PackedScene

func _ready():
	handle_connecting_signals()

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(slime_world)

func on_option_pressed() -> void:
	margin_container.visible = false
	option_menu.visible = true

func on_exit_pressed() -> void:
	get_tree().quit()

func exit_option_menu() -> void:
	margin_container.visible = true
	option_menu.visible = false

func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_pressed)
	option.button_down.connect(on_option_pressed)
	exit.button_down.connect(on_exit_pressed)
	option_menu.option_exit.connect(exit_option_menu)
