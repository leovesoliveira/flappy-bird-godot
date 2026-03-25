extends Node2D

@onready var score_ui: Node2D = %ScoreUI
@onready var score_number: Label = %ScoreNumber
@onready var high_score_number: Label = %HighScoreNumber

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_number.text = str(GameManager.score)
	high_score_number.text = str(GameManager.high_score)
	
	if GameManager.current_state == GameManager.State.GAME_OVER:
		score_ui.hide()
		show()
