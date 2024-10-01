extends Area2D
var move
const SPEED = 200

func _ready():
	var rotate=rotation#*PI/180
	move = Vector2(cos(rotate),sin(rotate))
	await get_tree().create_timer(10).timeout
	queue_free()

func _process(delta):
	position+=move*delta*SPEED


func _on_body_entered(body):
	if (body.name=="Player"):
		print("Fireball Hurt")
		get_parent().get_parent().bullet_mes=true
		queue_free()




