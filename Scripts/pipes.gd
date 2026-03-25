extends Node2D


var speed = 70


func _process(delta):
	if GameManager.current_state == GameManager.State.GAME_OVER:
		return
		
	position.x -= speed * delta
	
	if position.x < -100: 
		queue_free()
