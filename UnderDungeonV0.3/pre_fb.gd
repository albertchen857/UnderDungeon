extends AnimatedSprite2D

func _ready():
	play()
	await get_tree().create_timer(2).timeout
	queue_free()

