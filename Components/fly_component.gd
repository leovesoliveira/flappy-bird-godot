class_name FlyComponent extends Node


@export var body: CharacterBody2D
@export var model: Node2D

var wants_fly := false

const GRAVITY := 1000.0
const JUMP_VELOCITY := -270.0
const ANIMATION_MAX_DEG := deg_to_rad(65)
const ANIMATION_ROTATION_VELOCITY := 10.0

func tick(delta: float) -> void:	
	fly(delta)
	animate(delta)
	
func fly(delta: float):
	if body == null:
		return
		
	if not body.is_on_floor():
		body.velocity.y += GRAVITY * delta
	
	if wants_fly and GameManager.current_state == GameManager.State.PLAY:
		body.velocity.y = JUMP_VELOCITY
	
	body.move_and_slide()
	
func animate(delta):
	if body == null or model == null:
		return
		
	var fall_strength = clamp(body.velocity.y / 500.0, -1.0, 1.0)
	var target = fall_strength * ANIMATION_MAX_DEG
	
	model.rotation = lerp_angle(model.rotation, target, ANIMATION_ROTATION_VELOCITY * delta)
