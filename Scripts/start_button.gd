extends Button


@onready var transition_sound: AudioStreamPlayer2D = %TransitionSound


func _ready():
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	transition_sound.play()
	GameManager.change_scene("res://Scenes/game.tscn")
	GameManager.change_state(GameManager.State.PRE_PLAY)
