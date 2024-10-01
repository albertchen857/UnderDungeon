extends Node

var fight = preload("res://src/Brainiac Maniac.mp3")
var start = preload("res://src/Once Upon a Time.mp3")# 
var bgm = preload("res://src/blocks.ogg")
var storage = preload("res://src/loonboom.mp3")
var win = preload("res://src/Zen Garden.mp3")
var end = preload("res://src/end.ogg")


func _ready():
	$StartPoint.global_position=Vector2(324,316)
	$dead.hide()
	var alpha = 0.8
	$st.color=Color("ffffff",alpha)
	for i in range(8):
		alpha-=0.1
		$st.color=Color("ffffff",alpha)
		await get_tree().create_timer(0.1).timeout
	$st.hide()


func www():
	$st.show()
	$st.position.x=2650
	var alpha = 0
	$st.color=Color("ffffff",alpha)
	for i in range(100):
		alpha+=0.01
		$st.color=Color("ffffff",alpha)
		await get_tree().create_timer(0.01).timeout

func _on_player_gameover():
	await get_tree().create_timer(3).timeout
	$dead.show()


func _on_button_pressed():
	get_tree().quit()


func _on_guard_player_win():
	$Camera2D.queue_free()
	await get_tree().create_timer(1).timeout
	$bgm.stream = win
	$bgm.play()


func fight_music_play(enable:bool):
	$bgm.stream = fight
	if enable:
		$bgm.play()
	else:
		$bgm.stop()


func storage_music_play():
	$bgm.stream = storage
	$bgm.play()


func bgm_music_play():
	$bgm.stream = bgm
	$bgm.play()


func Win_music_play():
	$bgm.stream = win
	$bgm.play()


func end_music_play():
	$bgm.stream = end
	$bgm.play()
