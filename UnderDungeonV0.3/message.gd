extends Node
signal YdoorFree
signal BdoorFree
signal zoom_sm
signal zoom_rg
signal start

signal show_lable(district)

var ykey = false
var bkey = false
var zoomNum = 0
var GuardzoomNum = 0
var velocityH = false
var velocityV = false

func _ready():
	await get_tree().create_timer(0.1).timeout
	show_lable.emit("Hall Entry")


func _on_st_body_entered(body):
	$door1mes/Label.hide()
	$door2mes/Label.hide()
	$door3mes/Label.hide()
	$zoom_maze/Label.hide()
	$st.queue_free()
	

func _on_door_1_mes_body_entered(body):
	$door1mes/Label.show()


func _on_door_1_mes_body_exited(body):
	$door1mes/Label.hide()


func _on_door_2_mes_body_entered(body):
	if (ykey):
		YdoorFree.emit()
		$door2mes.queue_free()
	else:
		$door2mes/Label.show()


func _on_door_2_mes_body_exited(body):
	$door2mes/Label.hide()


func _on_door_3_mes_body_entered(body):
	if (bkey):
		BdoorFree.emit()
		$door3mes.queue_free()
	else:
		$door3mes/Label.show()


func _on_door_3_mes_body_exited(body):
	$door3mes/Label.hide()


func _on_player_bkey_back():
	bkey=true


func _on_player_ykey_back():
	ykey=true


func _on_zoom_maze_body_entered(body):
	zoomNum+=1
	if (zoomNum%2==1):
		zoom_sm.emit()
	elif (zoomNum%2==0):
		zoom_rg.emit()


func _on_zoom_maze_body_entered_lable_visible(body):
		if (zoomNum==1):
			$zoom_maze/Label.show()
		elif (zoomNum==2):
			$zoom_maze/Label.hide()


func _on_district_entry_trig_body_entered(body):
	if body.name=="Player":
		show_lable.emit("Entry")


func _on_district_hallway_trig_body_entered(body):
	if body.name=="Player":
		show_lable.emit("Hallway")


func _on_district_storage_trig_body_entered(body):
	if body.name=="Player":
		show_lable.emit("Storage")
		get_parent().storage_music_play()


func _on_district_guard_trig_body_entered(body):
	if body.name=="Player":
		show_lable.emit("Guard Room")
		get_parent().fight_music_play(true)

func _on_guard_mes_body_entered(body):
	if body.name=="Player":
		GuardzoomNum+=1
		if (GuardzoomNum==1):
			start.emit()


func _on_exit_trig_body_entered(body):
	await get_parent().www()
	get_tree().change_scene_to_file("res://win.tscn")


func _on_district_storage_trig_body_exited(body):
	if body.name=="Player":
		get_parent().bgm_music_play()


func _on_district_guard_trig_body_exited(body):
	if body.name=="Player":
		get_parent().bgm_music_play()


func _on_guard_player_win():
	get_parent().fight_music_play(false)
