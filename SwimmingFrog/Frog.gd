extends KinematicBody2D

onready var sprite := $AnimatedSprite

const SPEED := 500
var last_velocity := Vector2(0.0, 0.0)
var entropy := Vector2(0.975, 0.975) 
var x := 0.0
var y := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity:Vector2

	if x == 0 and y == 0:
		velocity = Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	else:
		velocity = Vector2(x,y)
		
	
	if velocity == Vector2.ZERO:
		if last_velocity.length_squared() > 0.1:
			velocity = last_velocity * entropy
	else:
		velocity = velocity.normalized()
		sprite.look_at(position+velocity)
	last_velocity = velocity
	
	if velocity.length_squared() > 0.1:
		sprite.play("default")
	else:
		sprite.stop()
	
	var _collision:KinematicCollision2D = move_and_collide(velocity * delta * SPEED)
	
func move_to_layer(l:int):
	layers = pow(2, l) as int
	
