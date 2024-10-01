extends Node
@export var fast_mode:bool = false

func _ready():
	$tutorial.hide()
	$setting.hide()
	setting()


func _process(delta):
	if Input.is_action_just_pressed("start_game"):
		get_tree().change_scene_to_file("res://main.tscn")
	elif Input.is_action_just_pressed("tutorial_exit"):
		$tutorial.hide()
		$setting.hide()

func _on_button_pressed():
	get_node("/root/GameData").difficulty=$oB.get_selected_id()
	get_node("/root/GameData").fast_mode=fast_mode
	for i in range(115):
		$exit/ColorRect.position+=Vector2(5.76,3.24)
		$exit/ColorRect2.position+=Vector2(5.76,-3.24)
		$exit/ColorRect3.position+=Vector2(-5.76,-3.24)
		$exit/ColorRect4.position+=Vector2(-5.76,3.24)
		$bgm.volume_db-=0.75
		await get_tree().create_timer(0.01).timeout
	if fast_mode:
		get_tree().change_scene_to_file("res://main.tscn")
	else:
		get_tree().change_scene_to_file("res://bgstory.tscn")


func _on_tutorial_pressed():
	$tutorial.show()


func _on_setting_pressed():
	$setting.show()

func setting():
	$oB.add_item("Easy",3)
	$oB.add_item("Normal",2)
	$oB.add_item("Hardcore",1)
	
	
func _on_c_b_pressed():
	fast_mode = !fast_mode
