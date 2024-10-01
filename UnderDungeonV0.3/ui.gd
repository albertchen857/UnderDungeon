extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$District.show()


func _on_message_show_lable(district):
	$District.show()
	$District.text=district
