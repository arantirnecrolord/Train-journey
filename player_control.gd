extends CharacterBody3D

var speed = 50

func _ready():
	pass

func _process(_delta):
	move_player()
	
func move_player():
	velocity = Vector3(Input.get_axis("a", "d"), -1, Input.get_axis("w", "s")).normalized() * speed
	move_and_slide()
