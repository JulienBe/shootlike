extends KinematicBody2D

export (int) var maxSpeed
export (int) var acceleration
var velocity = Vector2()
var zero = Vector2(0, 0)

func _ready():
	pass

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x += acceleration
	if Input.is_action_pressed("ui_left"):
		velocity.x -= acceleration
	if Input.is_action_pressed("ui_down"):
		velocity.y += acceleration
	if Input.is_action_pressed("ui_up"):
		velocity.y -= acceleration
#	if (velocity.length_squared() > maxSpeed):
#		velocity = velocity.normalized() * maxSpeed
	velocity = move_and_slide(velocity)
	velocity.x = 0
	velocity.y = 0
