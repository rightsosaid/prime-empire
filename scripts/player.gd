extends CharacterBody2D

# Movement speed in pixels per second
# 80px at 320x180 resolution feels like classic RPG pace
const SPEED = 80.0

# Track facing direction for animations later
var facing = "down"

func _physics_process(_delta: float) -> void:
	var direction = Vector2.ZERO

	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	# Normalize so diagonal movement isn't faster
	if direction != Vector2.ZERO:
		direction = direction.normalized()

		# Track facing direction for when we add walk animations
		if direction.y > 0:
			facing = "down"
		elif direction.y < 0:
			facing = "up"
		elif direction.x > 0:
			facing = "right"
		elif direction.x < 0:
			facing = "left"

	velocity = direction * SPEED
	move_and_slide()
