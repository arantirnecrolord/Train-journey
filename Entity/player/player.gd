extends CharacterBody3D

@export var walk_speed = 5.0
@export var jump_velocity = 4.5
@export var tps_camera : Node3D
@export var model : Node3D
@onready var raycast: RayCast3D = $TPSCamera/RayCast3D


var dt = Marker3D.new()
var dc = Marker3D.new()

func _ready() -> void:
	add_child(dt)
	add_child(dc)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump_velocity

	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction : Vector3 = (tps_camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * walk_speed
		velocity.z = direction.z * walk_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)
		velocity.z = move_toward(velocity.z, 0, walk_speed)
	
	dt.rotation.y = tps_camera.rotation.y
	if direction.length() >= 0.001:
		dc.look_at(model.global_position+direction)
	model.rotation.y = lerp_angle(model.rotation.y, dc.rotation.y, 0.1)

	move_and_slide()
	
	
	if raycast.is_colliding():
		var temp_item: Node3D = raycast.get_collider() as Node3D
		if Input.is_action_just_pressed("LMB"):
			print("оп")
			if temp_item.get_groups().has("switch"):
				print("клац")
				temp_item.switch()
