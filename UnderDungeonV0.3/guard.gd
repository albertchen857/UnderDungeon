extends Area2D
signal bullet
signal playerWin


var bullet_mes = false
const central_pos = Vector2(10,250)
var guardLife = 120
var num = 0
var nme = "bt"+str(num)
var difficulty

func _ready():
	difficulty=get_node("/root/GameData").difficulty
	$AnimatedSprite2D.stop()
	$Label.hide()
	$attack/FireBall.queue_free()
	$attack/Lazer.queue_free()
	$bossLife.hide()
	$Explotion1.hide()
	$Explotion2.hide()
	$Explotion3.hide()
	if difficulty==3:
		$bossLife/Diffi.text="Easy"
		$bossLife/Diffi.add_theme_color_override("font_color",Color(0,250,0,1))
	elif difficulty==2:
		$bossLife/Diffi.text="Normal"
		$bossLife/Diffi.add_theme_color_override("font_color",Color(250,250,0,1))
	elif difficulty==1:
		$bossLife/Diffi.text="Hardcore"
		$bossLife/Diffi.add_theme_color_override("font_color",Color(250,0,0,1))
	

func _process(delta):
	if bullet_mes:
		bullet.emit()
		bullet_mes = false
	$bossLife/guardlife.text=str(100-int(guardLife/120.0*100.0))+"%"
	if guardLife<5 or Input.is_action_just_pressed("cheat_guardead"):
		get_parent().end_music_play()
		$Explotion1.show()
		$Explotion1.play()
		await get_tree().create_timer(1).timeout
		$Explotion2.show()
		$Explotion2.play()
		await get_tree().create_timer(1).timeout
		$Explotion3.show()
		$Explotion3.play()
		await get_tree().create_timer(2).timeout
		playerWin.emit()
		queue_free()
		
func _on_message_start():
	$attack.global_position=Vector2(2102,-448)
	$AnimatedSprite2D.play()
	for i in range(25):
		position.y-=10
		await get_tree().create_timer(0.05).timeout
	await showText("NO ONE CAN EXIT THE DUNGEON!")
	await showText("Here is your Grave!")
	
	
	$bossLife.show()
	await A1()
	await A2()
	A3F()
	await A3L()
	

func BulIns(direct:Vector2,rotate,mode:String):
	if mode=="LZ":
		nme=load("res://lazer.tscn").instantiate()
	else:
		nme=load("res://fire_ball.tscn").instantiate()
	nme.position = direct+central_pos
	nme.rotation = rotate
	$attack.add_child(nme)
	num+=1
	nme="bt"+str(num)


func PreFB(direct:Vector2):
	nme = load("res://pre_fb.tscn").instantiate()
	nme.position = direct+central_pos
	$attack.add_child(nme)
	num+=1
	nme="bt"+str(num)


func showText(tx):
	$Label.show()
	$Label.text=tx
	await get_tree().create_timer(2).timeout
	$Label.hide()


func A1():
	for i in range(-300,301,100):
		BulIns(Vector2(i,-300),PI/2,"FB")
	await get_tree().create_timer(3).timeout
	for i in range(-300,301,100):
		BulIns(Vector2(-300,i),0,"FB")
	await get_tree().create_timer(3).timeout
	for i in range(-300,301,100):
		BulIns(Vector2(i,300),PI*1.5,"FB")
	await get_tree().create_timer(3).timeout
	for i in range(-300,301,100):
		BulIns(Vector2(300,i),PI,"FB")
	await get_tree().create_timer(3).timeout
	guardLife-=10
	PreFB(Vector2(0,0))
	await showText("SHOW MY SPINING FIREBALL")
	for i in range(0,120,6):
		BulIns(Vector2(0,0),0+i,"FB")
		BulIns(Vector2(0,0),PI+i,"FB")
		BulIns(Vector2(0,0),PI*1.5+i,"FB")
		BulIns(Vector2(0,0),PI/2+i,"FB")
		BulIns(Vector2(0,0),PI/4+i,"FB")
		BulIns(Vector2(0,0),PI*1.25+i,"FB")
		BulIns(Vector2(0,0),PI*1.75+i,"FB")
		BulIns(Vector2(0,0),PI/1.5+i,"FB")
		await get_tree().create_timer(0.7).timeout
	guardLife-=20
	await get_tree().create_timer(3).timeout
	PreFB(Vector2(300,300))
	PreFB(Vector2(-300,-300))
	await showText("ERR~ YOU CANT RAN AWAY")
	for i in range(20):
		BulIns(Vector2(300,300),PI,"FB")
		BulIns(Vector2(300,300),PI*1.125,"FB")
		BulIns(Vector2(300,300),PI*1.25,"FB")
		BulIns(Vector2(300,300),PI*1.375,"FB")
		BulIns(Vector2(300,300),PI*1.5,"FB")
		BulIns(Vector2(-300,-300),0,"FB")
		BulIns(Vector2(-300,-300),PI*0.125,"FB")
		BulIns(Vector2(-300,-300),PI*0.25,"FB")
		BulIns(Vector2(-300,-300),PI*0.375,"FB")
		BulIns(Vector2(-300,-300),PI*0.5,"FB")
		await get_tree().create_timer(0.7).timeout
	$bossLife/level.text="LEVEL 2"
	guardLife-=15
	await get_tree().create_timer(3).timeout
	

func A2():
	await showText("PWOER OF LAZER!")
	BulIns(Vector2(150,-400),PI/2,"LZ")
	BulIns(Vector2(-0,-400),PI/2,"LZ")
	BulIns(Vector2(-150,-400),PI/2,"LZ")
	BulIns(Vector2(400,-150),PI,"LZ")
	BulIns(Vector2(400,0),PI,"LZ")
	BulIns(Vector2(400,150),PI,"LZ")
	await get_tree().create_timer(2).timeout
	BulIns(Vector2(-400,-400),0.25*PI,"LZ")
	BulIns(Vector2(400,-400),0.75*PI,"LZ")
	BulIns(Vector2(0,-400),0.25*PI,"LZ")
	BulIns(Vector2(0,400),1.25*PI,"LZ")
	BulIns(Vector2(-400,-0),1.75*PI,"LZ")
	BulIns(Vector2(400,0),0.75*PI,"LZ")
	await get_tree().create_timer(2).timeout
	guardLife-=10
	await showText("See my LAZER PRO")
	for i in range(-300,300,100):
		BulIns(Vector2(i,-400),PI/2,"LZ")
		await get_tree().create_timer(0.2).timeout
	await get_tree().create_timer(1.5).timeout
	for i in range(300,-300,-100):
		BulIns(Vector2(400,i),PI,"LZ")
		await get_tree().create_timer(0.2).timeout
	await get_tree().create_timer(1.5).timeout
	for i in range(300,-400,-100):
		BulIns(Vector2(i,-400),PI*0.25,"LZ")
		await get_tree().create_timer(0.15).timeout
	for i in range(-400,200,100):
		BulIns(Vector2(-400,i),PI*0.25,"LZ")
		await get_tree().create_timer(0.15).timeout
	guardLife-=15
	$bossLife/level.text="LEVEL 3"


func A3F():
	await get_tree().create_timer(2).timeout
	PreFB(Vector2(-300,300))
	await showText("I AM SO MAD!")
	for i in range(15):
		BulIns(Vector2(-300 ,300),PI*1.75,"FB")
		BulIns(Vector2(-300 ,-200),0,"FB")
		BulIns(Vector2(200 ,-300),PI/2,"FB")
		BulIns(Vector2(-200 ,300),PI*1.5,"FB")
		await get_tree().create_timer(1).timeout
	await showText("FXX! WHY YOU ARE STILL ALIVE")
	
	for t in range(2):
		for i in range(300,-300,-50):
			BulIns(Vector2(-300 ,i),0,"FB")
			await get_tree().create_timer(0.5).timeout
		for i in range(-300,300,50):
			BulIns(Vector2(-300 ,i),0,"FB")
			await get_tree().create_timer(0.5).timeout
	await showText("MY FINAL ENERGY!")
	for i in range(30):
		BulIns(Vector2(randi_range(-300,300) ,-300),PI/2,"FB")
		BulIns(Vector2(randi_range(-300,300) ,300),PI*1.5,"FB")
		BulIns(Vector2(-300 ,randi_range(-300,300)),0,"FB")
		BulIns(Vector2(300 ,randi_range(-300,300)),PI,"FB")
		await get_tree().create_timer(randf_range(1.5,2.0)).timeout
		


func A3L():
	await get_tree().create_timer(5).timeout
	for i in range(-300,300,75):
		BulIns(Vector2(i,-400),PI/2,"LZ")
		await get_tree().create_timer(1.5).timeout
	await get_tree().create_timer(1.5).timeout
	guardLife-=20
	await get_tree().create_timer(3).timeout
	for i in range(10):
		BulIns(Vector2(randi_range(-6,6)*50 ,-400),PI/2,"LZ")
		await get_tree().create_timer(2).timeout
	guardLife-=20
	await get_tree().create_timer(5).timeout
	for i in range(12):
		BulIns(Vector2(-400,0),randf_range(1.75*PI,2.25*PI),"LZ")
		BulIns(Vector2(400,0),randf_range(0.75*PI,1.25*PI),"LZ")
		await get_tree().create_timer(2).timeout
		BulIns(Vector2(0,400),randf_range(1.25*PI,1.75*PI),"LZ")
		BulIns(Vector2(0,-400),randf_range(0.25*PI,0.75*PI),"LZ")
		await get_tree().create_timer(2).timeout
	await get_tree().create_timer(2.5).timeout
	guardLife-=20
	

func _on_player_gameover():
	await get_tree().create_timer(1).timeout
	queue_free()
