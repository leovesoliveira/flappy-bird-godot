extends Node2D


@onready var pipes_spawner: Timer = %PipesSpawner
var pipes_scene = preload("res://Scenes/pipes.tscn")
var min_y = 20
var max_y = -55


func _ready() -> void:
	GameManager.reset_score()
	pipes_spawner.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	if GameManager.current_state == GameManager.State.GAME_OVER:
		return
		
	if GameManager.current_state == GameManager.State.PLAY:
		spawn_pipe()

func spawn_pipe():
	var new_pipes = pipes_scene.instantiate()
	
	var random_y = randf_range(min_y, max_y)
	new_pipes.position = Vector2(100, random_y)
	
	add_child(new_pipes)
