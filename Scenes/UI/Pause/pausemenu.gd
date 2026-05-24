extends Control

func _ready() -> void:
	visible = false
	get_tree().paused = false
	# This is the only process_mode you need!
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			resume()
		else:
			pause()

func pause() -> void:
	visible = true
	get_tree().paused = true

func resume() -> void:
	visible = false
	get_tree().paused = false

func _on_resume_pressed() -> void:
	resume()

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main menus/Mainmenu_assets/main_menu.tscn")
