extends Node3D

@export var follow_target : Node

@export var sensitivity : float = 0.1
@export_range(-1, 1) var invert_y : float = 1
@export_group("Lag")
@export_range(0, 1) var rotation_lag : float = 0.8
@export_range(0, 1) var location_lag : float = 0.1
@export_group("Rotation Clamp")
@export_range(0, 90) var max_rotation : float = 80
@export_range(-90, 0) var min_rotation : float = -80

var rot_rad_vert : float 
var rot_rad_hor : float

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rot_rad_vert = deg_to_rad(-event.relative.y*invert_y*sensitivity)
		rot_rad_hor = deg_to_rad(-event.relative.x*invert_y*sensitivity)


func _process(_delta):
	$SpringArm.rotation.x = clamp(
		lerp($SpringArm.rotation.x, $SpringArm.rotation.x+rot_rad_vert, rotation_lag),
		deg_to_rad(-80),
		deg_to_rad(80)
	)
	self.rotation.y = lerp(self.rotation.y, self.rotation.y+rot_rad_hor, rotation_lag)
	self.global_position = lerp(self.global_position, follow_target.global_position, location_lag)
	rot_rad_vert = 0
	rot_rad_hor = 0
