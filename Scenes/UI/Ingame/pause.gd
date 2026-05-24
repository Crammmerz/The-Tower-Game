extends CanvasLayer

func _ready() -> void:
	visible = false
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Connect buttons via code
	$PanelContainer/VBoxContainer/Resume.pressed.connect(_on_resume_pressed)
	$PanelContainer/VBoxContainer/Main_menu.pressed.connect(_on_main_menu_pressed)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if GameEvents.is_game_over: return
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

func _on_main_menu_pressed() -> void:
	EntityPoolManager.clear_pools() 
	GameEvents.reset()  
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main menus/Mainmenu_assets/main_menu.tscn")
