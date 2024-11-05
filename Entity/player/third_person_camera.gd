extends Node3D

var mouse_sensitivity : Vector2 = Vector2(0.005, 0.005)
var spring_arm_min : float = 1.5
var spring_arm_max : float = 8.0
var spring_arm_zoom_scale : float = 1.5
var zoom_smoothing : float = 0.2

var target_zoom : float = 2.0
var pause = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and !pause:
		self.rotate_y(-event.relative.x * mouse_sensitivity.x)
		$SpringArm3D.rotate_x(-event.relative.y * mouse_sensitivity.y)

#unc _physics_process(delta: float) -> void:
	#if Input.is_action_just_pressed("zoom_in"):
		#target_zoom = clamp(target_zoom/spring_arm_zoom_scale, spring_arm_min, spring_arm_max)
	#if Input.is_action_just_pressed("zoom_out"):
		#target_zoom = clamp(target_zoom*spring_arm_zoom_scale, spring_arm_min, spring_arm_max)
	#$SpringArm3D.spring_length = lerp($SpringArm3D.spring_length, target_zoom, zoom_smoothing)
	if Input.is_action_just_pressed("esc"):
		pause = !pause
		if !pause: 
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
