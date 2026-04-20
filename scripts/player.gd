extends CharacterBody2D

const SPEED = 80.0

var facing = "down"

func _physics_process(_delta: float) -> void:
	var direction = Vector2.ZERO

	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")

	if direction != Vector2.ZERO:
		direction = direction.normalized()

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
