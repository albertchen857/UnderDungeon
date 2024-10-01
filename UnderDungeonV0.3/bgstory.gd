extends Node2D

var bgs1 = preload("res://img/bgStorg1.png")
var bgs2 = preload("res://img/bgStorg2.png")
var bgs3 = preload("res://img/bgStorg3.png")
var bgs4 = preload("res://img/bgStorg4.png")
var bgs5 = preload("res://img/bgStorg5.png")
var bgs6 = preload("res://img/bgStorg6.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture=bgs1
	$Label.text="Human and Robot live together on the Earth"
	await get_tree().create_timer(9.5).timeout
	$Sprite2D.texture=bgs2
	$Label.text="Robots beats human and occupied all the Earth"
	await get_tree().create_timer(5).timeout
	$Sprite2D.texture=bgs3
	$Label.text="Few years later 210X"
	await get_tree().create_timer(5).timeout
	$Label.text="Robots decide to transform all human into robots"
	$Sprite2D.texture=bgs4
	await get_tree().create_timer(5).timeout
	$Label.text="Human revolution start and you are the leader"
	$Sprite2D.texture=bgs5
	await get_tree().create_timer(5).timeout
	$Label.text="Revolution failed, robots transform you into a robot and throw you under the robot dungeon"
	$Sprite2D.texture=bgs6
	
	for i in range(10):
		$AudioStreamPlayer.volume_db-=1
		await get_tree().create_timer(1.05).timeout
	get_tree().change_scene_to_file("res://main.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("tutorial_exit"):
		get_tree().change_scene_to_file("res://main.tscn")
	

