extends Node2D

signal hit

export (int) var speed
var screensize

func _ready():
    screensize = get_viewport().size
    pass
    
func start(pos):
    position = pos
    show()
    $Area2D/CollisionShape2D.disabled = false

func _process(delta):
    var velocity = Vector2() # The player's movement vector.
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
    position += velocity * delta
    position.x = clamp(position.x, 0, screensize.x)
    position.y = clamp(position.y, 0, screensize.y)

func _on_Area2D_body_entered(body):
    hide()
    emit_signal("hit")
    $Area2D/CollisionShape2D.disabled = true
    pass # replace with function body
