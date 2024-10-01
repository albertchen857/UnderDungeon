extends Node2D


func _ready():
	var difficulty = get_node("/root/GameData").difficulty
	print(difficulty)
	if difficulty == 1:
		$Label2.add_theme_color_override("font_color", Color(225,0,0))
		$Label2.text="MODE:HARDCORE"
	elif difficulty == 2:
		$Label2.add_theme_color_override("font_color", Color(225,225,0))
		$Label2.text="MODE:NOMAL"
	else:
		$Label2.add_theme_color_override("font_color", Color(0,225,0))
		$Label2.text="MODE:EASY"


func _on_button_pressed():
	get_tree().quit()
