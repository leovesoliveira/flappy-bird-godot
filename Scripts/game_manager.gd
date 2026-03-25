extends Node

signal state_changed

enum State {
	START,
	PRE_PLAY,
	PLAY,
	GAME_OVER
}
@export var current_state := State.START

var fade_overlay: ColorRect
var score: int = 0
var high_score: int = 0
const SAVE_PATH = "user://highscore.save"

func _ready():	
	load_high_score()
	
	fade_overlay = ColorRect.new()
	
	var canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 100
	canvas_layer.add_child(fade_overlay)
	add_child(canvas_layer)
	
	fade_overlay.color = Color(0, 0, 0, 1)
	fade_overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	fade_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade_overlay.modulate.a = 0.0

func fade_in(duration: float) -> Tween:
	fade_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = create_tween()
	tween.tween_property(fade_overlay, "modulate:a", 1.0, duration).from(0.0)
	return tween

func fade_out(duration: float) -> Tween:
	var tween = create_tween()
	tween.tween_property(fade_overlay, "modulate:a", 0.0, duration).from(1.0)
	tween.finished.connect(func(): fade_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE)
	return tween

func change_state(state: State) -> void:
	current_state = state
	state_changed.emit()
	
func change_scene(scene: String) -> void:
	await fade_in(0.3).finished
	get_tree().change_scene_to_file(scene)
	await get_tree().process_frame
	fade_out(0.3)

func add_score():
	score += 1
	if score > high_score:
		high_score = score
		save_high_score()

func reset_score():
	score = 0

func save_high_score():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(high_score)

func load_high_score():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		high_score = file.get_var()
