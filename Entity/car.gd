# це ще не дороблено
extends PathFollow3D

@onready var world = get_tree().root.get_child(0)
@onready var locomotive = get_parent().get_parent()

func _on_Area_area_entered(area):
	print("Зіткнення", locomotive.name)
	if area.name == "locomotive_area":
		world.engine_engaged = true
		locomotive.couple_to_cars()
