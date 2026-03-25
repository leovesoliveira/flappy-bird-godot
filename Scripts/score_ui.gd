extends Node2D

@onready var score_label: Label = %Label

func _process(_delta):
	score_label.text = str(GameManager.score)
