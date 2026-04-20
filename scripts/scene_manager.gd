extends Node

const FADE_DURATION = 0.4

var pending_spawn: String = ""

var _overlay: ColorRect
var _tween: Tween

func _ready() -> void:
	var canvas = CanvasLayer.new()
	canvas.layer = 100
	add_child(canvas)

	_overlay = ColorRect.new()
	_overlay.color = Color(0, 0, 0, 0)
	_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	canvas.add_child(_overlay)

func go_to(scene_path: String, spawn_point: String = "") -> void:
	pending_spawn = spawn_point
	await _fade_out()
	get_tree().change_scene_to_file(scene_path)
	# Wait two frames — one for scene to swap, one for all _ready() calls to finish
	await get_tree().process_frame
	await get_tree().process_frame
	_apply_spawn()
	await _fade_in()

func _apply_spawn() -> void:
	if pending_spawn == "":
		return
	var scene_root = get_tree().current_scene
	var player = scene_root.get_node_or_null("Player")
	var spawn = scene_root.get_node_or_null(pending_spawn)
	if player and spawn:
		player.global_position = spawn.global_position
	pending_spawn = ""

func _fade_out() -> void:
	_tween = create_tween()
	_tween.tween_property(_overlay, "color", Color(0, 0, 0, 1), FADE_DURATION)
	await _tween.finished

func _fade_in() -> void:
	_tween = create_tween()
	_tween.tween_property(_overlay, "color", Color(0, 0, 0, 0), FADE_DURATION)
	await _tween.finished
