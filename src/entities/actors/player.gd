extends KinematicBody2D

const ZERO = Vector2(0, 0)

const speed = 100.0
var velocity

func _ready():
	print("ready")
	pass

func _input(event):
	if Input.is_action_pressed("action.use"):
		print("use")
	pass

func _physics_process(dt):
	movement(dt)
	actions(dt)

func movement(dt):
	velocity = ZERO

	if Input.is_action_pressed("move.up"):
		velocity += Vector2(0, -1)
	if Input.is_action_pressed("move.down"):
		velocity += Vector2(0, 1)
	if Input.is_action_pressed("move.left"):
		velocity += Vector2(-1, 0)
	if Input.is_action_pressed("move.right"):
		velocity += Vector2(1, 0)

	move_and_slide(velocity * speed)

func actions(dt):
	pass
