class_name DieComponent extends Node


@export var body: CharacterBody2D


func tick() -> void:
	if body.is_on_floor():
		GameManager.change_state(GameManager.State.GAME_OVER)
		
