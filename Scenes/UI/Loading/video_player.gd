extends VideoStreamPlayer

func _ready() -> void:
	self.play()
	await get_tree().create_timer(9.3).timeout
	self.queue_free()
	get_tree().change_scene_to_file("res://Scenes/UI/Mainmenu_assets/main_menu.tscn")
