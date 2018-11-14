extends KinematicBody2D

const ZERO = Vector2(0, 0)
const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

const zoomMax = 1.0
const zoomMin = 0.2
const zoomStep = Vector2(0.1, 0.1)

const camDistance = 128.0
const speed = 100.0

var anim: String
var animSpeed := 1.0
var animTween := 0.2
var velocity := ZERO

onready var viewport = get_node("viewport")
onready var sprite = get_node("sprite")
onready var model = viewport.get_node("model")
onready var animPlayer = model.get_node("animationPlayer")
onready var pivot = get_node("pivot")
onready var camOffset = pivot.get_node("camOffset")
onready var cam = camOffset.get_node("cam")

func _ready():
	sprite.texture = viewport.get_texture()

	animPlayer.get_animation("Idle").loop = true
	animPlayer.get_animation("Walk").loop = true

	zoom()

func _input(event):
	if Input.is_action_pressed("action.use"):
		print("use")
	if Input.is_action_pressed("cam.zoom-in") and cam.zoom.x > zoomMin:
		zoom(-1)
	if Input.is_action_pressed("cam.zoom-out") and cam.zoom.x < zoomMax:
		zoom(1)

func _physics_process(dt):
	movement(dt)

func _process(dt):
	actions(dt)

func movement(dt):
	velocity = ZERO

	var currentAnim = anim

	if Input.is_action_pressed("move.up"):
		velocity += UP
	if Input.is_action_pressed("move.down"):
		velocity += DOWN
	if Input.is_action_pressed("move.left"):
		velocity += LEFT
	if Input.is_action_pressed("move.right"):
		velocity += RIGHT

	velocity = velocity.clamped(1)

	if velocity == ZERO:
		currentAnim = "Idle"
	else:
		camOffset.position = Vector2(camDistance * cam.zoom.x, 0)

		currentAnim = "Walk"
		pivot.rotation = velocity.angle()
		model.rotation = Vector3(0, velocity.angle() - PI/2, 0)
		velocity = move_and_slide(velocity * speed)

	if currentAnim != anim:
		anim = currentAnim
		animPlayer.play(currentAnim, animTween, animSpeed)

func actions(dt):
	pass

func zoom(scalar: float = 0.0):
	cam.zoom = cam.zoom + scalar * zoomStep
	camOffset.position = ZERO

	var dragMargin = 0.5 * cam.zoom.x
	cam.drag_margin_top = dragMargin
	cam.drag_margin_bottom = dragMargin
	cam.drag_margin_left = dragMargin
	cam.drag_margin_right = dragMargin
	pass
