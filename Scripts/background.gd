extends Parallax2D


@export var scroll_speed: Vector2 = Vector2(-4, 0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	autoscroll = scroll_speed
	GameManager.state_changed.connect(_on_state_changed)
		
func _on_state_changed():		
	if GameManager.current_state == GameManager.State.GAME_OVER:
		autoscroll = Vector2.ZERO
