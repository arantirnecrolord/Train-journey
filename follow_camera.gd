extends Node

@export var camera : Node3D
@export var player : CharacterControllerx
@export var speed : float = 0.3

signal sharp_turn # TODO

func _process(event):
	if player.direction.length() > 0:
		player.rotation.y = lerp(player.rotation.y, camera.rotation.y, speed)
