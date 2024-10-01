extends Node2D

func _on_message_bdoor_free():
	$Door/door3.queue_free()


func _on_message_ydoor_free():
	$Door/door2.queue_free()


func _on_message_start():
	for i in range(68):
		$Door/door4.position.x-=1
		await get_tree().create_timer(0.01).timeout


func _on_guard_player_win():
	$Door/door4.queue_free()
