extends Area2D


export(String) var warp_to
const path := "res://Maps/"

# Called when the node enters the scene tree for the first time.
func _ready():
	S.my_collisions(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Warp_body_entered(body):
	if body.name == "Frog":
		var err := get_tree().change_scene(path.plus_file(warp_to + ".tscn"))
		if err != OK: push_warning("Err changing to " + warp_to + ": " + str(err))
