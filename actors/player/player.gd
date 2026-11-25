extends CharacterBody2D

const TILE_SIZE: int = 16

@export var speed: float = 80.0

var _target: Vector2
var _prev_direction: Vector2


func _ready() -> void:
	_target = position


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	# swap between horizontal and vertical movements
	if _prev_direction.x != 0 and direction.y != 0:
		direction.x = 0
	elif _prev_direction.y != 0 and direction.x != 0:
		direction.y = 0

	# reduce vector to only the four cardinal directions
	if direction.x != 0:
		direction.y = 0
		direction.x = signf(direction.x)
	elif direction.y != 0:
		direction.y = signf(direction.y)

	if position == _target:
		if direction != Vector2.ZERO:
			_prev_direction = direction
			_target = position + direction * TILE_SIZE
	else:
		# check if direction held is exact opposite of heading
		if direction != Vector2.ZERO and direction == -_prev_direction:
			_prev_direction = direction
			_target = _target + direction * TILE_SIZE

	position = position.move_toward(_target, speed * delta)
