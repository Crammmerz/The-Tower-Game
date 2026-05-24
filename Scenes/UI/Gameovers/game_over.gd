extends Control

var level_path = "res://Scenes/Game World/SlimeStage.tscn"

var messages = [
	"Git gud",
	"NT dumbass",
	"U GOT COOKED",
	"SKILL ISSUE",
	"NOT EVEN CLOSE",
	"TRY AGAIN?",
    "67 67 67"
]

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameEvents.player_died.connect(display_ui)

func display_ui():
	show()
	get_tree().paused = true
	$PanelContainer/VBoxContainer/message.text = messages[randi() % messages.size()]

func _on_restart_pressed() -> void:
	GameEvents.game_end.emit()
	get_tree().paused = false
	await get_tree().create_timer(0.1).timeout
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	GameEvents.game_end.emit()
	print("Pressed Menu")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/UI/Mainmenu_assets/main_menu.tscn")
