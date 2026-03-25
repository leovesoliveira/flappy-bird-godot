extends Area2D

@onready var score_sound: AudioStreamPlayer2D = %ScoreSound

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if GameManager.current_state == GameManager.State.PLAY:
			score_sound.play()
			GameManager.add_score()
