extends Area3D

@export var forward_path : Path3D # Колія відгалуження
@export var backward_path : Path3D # Основна колія
@export var active = true # Чи активний стрілочний первод
@onready var mesh_instance = $CollisionShape3D/MeshInstance3D

func _process(delta):
	if active == true:
		mesh_instance.mesh.surface_get_material(0).albedo_color = Color(0, 255, 0, 255)
	else: 
		mesh_instance.mesh.surface_get_material(0).albedo_color = Color(255, 0, 0, 255)

func _on_body_entered(body):
	if body.is_in_group("bogies"): # Перевірити чи зіткнення відбулось з елементом групи візків
		var bogie = body.get_parent() # Отримати батьківський елемент візку
		# Якщо візок рухається вперед, стрілочний перевод активний і візок на колії
		# то не дорівнює основній колії, тобто це умови щоб перенести візок на колію відгалуження
		if bogie.forward and active and bogie.path != forward_path:
			bogie.reparent(forward_path) # Перестворити візок на колії відгалуження
			bogie.path = forward_path # Задати нову колію як основну в скрипту візка
			# Отримати найближчий до візка progress колії
			bogie.progress = forward_path.curve.get_closest_offset(body.global_position) 
		# Те саме але в зворотньому напрямку
		elif bogie.forward == false and active and bogie.path != backward_path:
			bogie.reparent(backward_path)
			bogie.path = backward_path
			bogie.progress = backward_path.curve.get_closest_offset(body.global_position)
	
func switch() -> void:
	active = not active
	
