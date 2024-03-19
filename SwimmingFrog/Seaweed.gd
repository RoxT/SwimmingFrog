extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Seaweed_body_entered(body):
	match body.name:
		"Frog":
			S.inventory.seaweed += 1
			queue_free()
		"Rocks":
			queue_free()
		var other:
			print(other)
