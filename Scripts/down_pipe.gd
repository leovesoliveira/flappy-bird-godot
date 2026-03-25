extends Area2D

@onready var hurt_sound: AudioStreamPlayer2D = %HurtSound
@onready var fall_sound: AudioStreamPlayer2D = %FallSound

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if not body.is_hurted:
			body.is_hurted = true
			hurt_sound.play()
			get_tree().create_timer(0.3).timeout.connect(fall_sound.play)
			
		GameManager.change_state(GameManager.State.GAME_OVER)
