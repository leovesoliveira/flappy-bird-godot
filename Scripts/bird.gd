extends CharacterBody2D


@onready var input_component: InputComponent = %InputComponent
@onready var fly_component: FlyComponent = %FlyComponent
@onready var die_component: DieComponent = %DieComponent
@onready var tap_info: Sprite2D = %TapInfo
@onready var fly_sound: AudioStreamPlayer2D = %FlySound
@onready var hurt_sound: AudioStreamPlayer2D = %HurtSound

@export var is_hurted: bool = false
var can_fly := true
var is_freezed := true


func _physics_process(delta: float) -> void:
	if input_component.is_tapped and can_fly and GameManager.current_state == GameManager.State.PLAY:
		can_fly = false
		fly_component.wants_fly = true
		fly_sound.play()
	else: 
		fly_component.wants_fly = false
	
	if not input_component.is_tapped:
		can_fly = true
		
	if input_component.is_tapped and is_freezed:
		GameManager.change_state(GameManager.State.PLAY)
		is_freezed = false
	
	if not is_freezed:
		fly_component.tick(delta)
		
	tap_info.visible = is_freezed
		
	if is_on_floor() and not is_hurted:
		is_hurted = true
		hurt_sound.play()
		
	die_component.tick()
	
	
