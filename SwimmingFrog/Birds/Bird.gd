extends Area2D


var speed = 200
signal bird

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = position.x + (delta * speed)


func _on_Bird_body_entered(body):
	if S.is_player(body):
		modulate = Color.red
		emit_signal("bird")


func _on_Bird_body_exited(body):
	if S.is_player(body):
		modulate = Color.white

func _on_Timer_timeout():
	speed = -speed

func move_to_layer(new_layer:int):
	var bits := pow(2, new_layer) as int
	collision_layer = bits
	collision_mask = bits
	scale = Vector2(new_layer+1, new_layer+1)
	

