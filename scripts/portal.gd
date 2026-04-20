extends Area2D

@export var target_scene: String = ""
@export var spawn_point: String = ""

# Prevents portal from firing immediately when player spawns near it
var _ready_to_use := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	# Short delay before portal becomes active
	await get_tree().create_timer(0.5).timeout
	_ready_to_use = true

func _on_body_entered(body: Node) -> void:
	if _ready_to_use and body.name == "Player" and target_scene != "":
		_ready_to_use = false
		SceneManager.go_to(target_scene, spawn_point)
