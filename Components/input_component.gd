class_name InputComponent extends Node


var is_tapped := false


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		is_tapped = event.pressed
