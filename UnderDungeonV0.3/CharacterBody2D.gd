extends CharacterBody2D
signal YkeyBack
signal BkeyBack
signal gameover


@export var speed = 200
var screen_size
var zoom:Vector2
var ykey = false
var bkey = false
var difficulty
var life:float
var dif_life:float
var fast_mode
var hit = false


func _ready():
	$AnimatedSprite2D.animation="run"
	$ui/battery/lifebar.frame=0
	difficulty=get_node("/root/GameData").difficulty
	fast_mode = get_node("/root/GameData").fast_mode
	life = difficulty*difficulty
	dif_life=life
	#print(life,fast_mode)
	if fast_mode:
		ykey=true
		YkeyBack.emit()
		$ui/bg/task.text="go to guard room beat guar and get the blue key"


func _process(delta):
	pass


func _physics_process(delta):
	var direction = Input.get_axis("Move_left", "Move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	direction = Input.get_axis("Move_up", "Move_down")
	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	
	if !hit:
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play("run")	
		else:
			$AnimatedSprite2D.stop()
	else:
		$AnimatedSprite2D.play("hit")
	position += velocity * delta
	
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false


func _on_key_yellow_ykey_hit():
	ykey=true
	print("yellowkey:",ykey)
	YkeyBack.emit()
	$ui/bg/task.text="go to guard room beat guar and get the blue key"


func _on_key_blue_bkey_hit():
	bkey=true
	print("bluekey:",bkey)
	BkeyBack.emit()
	$ui/bg/task.text="go to right door on the hallway to exit"


func _on_message_zoom_rg():
	spe_zoom(15,35,false)


func _on_message_zoom_sm():
	spe_zoom(15,35,true)


func spe_zoom(start,end,type:bool):
	if (type):
		for i in range(start,end+1):
			zoom.x=i/10.0
			zoom.y=i/10.0
			$Camera2D.set_zoom(zoom)
			await get_tree().create_timer(0.001).timeout
	else:
		for i in range(end,start-1,-1):
			zoom.x=i/10.0
			zoom.y=i/10.0
			$Camera2D.set_zoom(zoom)
			await get_tree().create_timer(0.001).timeout


func _on_message_start():
	var x1=2100-position.x
	var y1=-480-position.y
	for i in range(30):
		$Camera2D.position.x+=x1/30
		$Camera2D.position.y+=y1/30
		$Camera2D.zoom.x-=0.025
		$Camera2D.zoom.y-=0.025
		await get_tree().create_timer(0.02).timeout
	$Camera2D.enabled=false




func _on_guard_bullet():
	hit = true
	life-=1.0
	var rate = life/dif_life
	print("life:",life,"persent:",rate)
	$ui/battery/Label.text=str(int(rate*100.00))+"%"
	$playerHit.play()
	await get_tree().create_timer(0.15).timeout
	hit = false
	$AnimatedSprite2D.animation="run"
	if rate>0.75:
		$ui/battery/lifebar.frame=1
	elif rate>0.5:
		$ui/battery/lifebar.frame=2
	elif rate>0.25:
		$ui/battery/lifebar.frame=3
	elif rate>0.1:
		$ui/battery/lifebar.frame=4
	else:
		$ui/battery/lifebar.frame=5
		print("gameover")
		gameover.emit()
		queue_free()
	


func _on_guard_player_win():
	$Camera2D.enabled=true
	$Camera2D.position=Vector2(0,0)
	$Camera2D.zoom=Vector2(1.5,1.5)
