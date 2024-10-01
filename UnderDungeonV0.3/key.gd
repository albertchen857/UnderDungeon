extends Node2D
signal YkeyHit
signal BkeyHit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_key_yellow_body_entered(body):
	if body.name=="Player":
		YkeyHit.emit()
		$Key_yellow.queue_free()


func _on_key_blue_body_entered(body):
	if body.name=="Player":
		BkeyHit.emit()
		$Key_blue.queue_free()


func _on_guard_player_win():
	$Key_blue.position=Vector2(2102,-448)
	$Key_blue.show()
