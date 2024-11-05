extends TextEdit

@onready var world = get_tree().root.get_child(0)
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if world.engine_engaged:
		visible = true
	pass
