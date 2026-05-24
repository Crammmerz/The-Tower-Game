extends Control

func _ready():
	# Connect all child buttons to one function
	for child in get_children():
		if child is TextureButton:
			child.pressed.connect(_on_texture_button_pressed.bind(child))


func _on_texture_button_pressed(button: TextureButton):

	# Button1
	if button.name == "Card1":
		button.get_node("Label1").text = "[center]Skill 1![/center]"

	# Button2
	elif button.name == "Card2":
		button.get_node("Label2").text = "[center]Skill 2![/center]"

	# Button3
	elif button.name == "Card3":
		button.get_node("Label3").text = "[center]Skill 3![/center]"
