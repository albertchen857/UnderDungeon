extends Area2D
var rotate=rotation
var avalible=true 

func _ready():
	$CollisionShape2D2.visible=false
	$AnimatedSprite2D.animation="red"
	await get_tree().create_timer(0.75).timeout
	$AnimatedSprite2D.animation="blue"
	$CollisionShape2D2.visible=true
	for i in range(65):
		if avalible:
			$AnimatedSprite2D.scale.y=i/10.0
			$CollisionShape2D2.scale.x=i/10.0
		await get_tree().create_timer(0.001).timeout
	await get_tree().create_timer(0.4).timeout
	queue_free()


func _on_body_entered(body):
	if (body.name=="Player" and $CollisionShape2D2.visible):
		avalible=false
		get_parent().get_parent().bullet_mes=true
		$AnimatedSprite2D.queue_free()
		$CollisionShape2D2.queue_free()

