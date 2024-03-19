extends Area2D

onready var label := $Label
export(String) var script_key
const QUOTE := "\"%s\""

# Called when the node enters the scene tree for the first time.
func _ready():
	label.hide()
	S.my_collisions(self)
	var errs := []
	errs.append( connect("body_entered", self, "_on_Friend_body_entered"))
	errs.append( connect("body_exited", self, "_on_Friend_body_exited"))
	S.print_errs(errs, "Error connecting Friend to itself")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Friend_body_entered(body):
	if body.name == "Frog":
		label.text = QUOTE % tr(script_key)
		label.show()


func _on_Friend_body_exited(body):
	if body.name == "Frog":
		$Label.text = QUOTE % tr(script_key)
		label.hide()
