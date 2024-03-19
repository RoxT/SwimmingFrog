extends Area2D

export(int) var build_amount = 5
signal visting_nest(nest)
signal left_nest
const NEEDS := "Need %s seaweed"
const TITLE := "Bugnest"

# Called when the node enters the scene tree for the first time.
func _ready():
	S.my_collisions(self)
	$Label.text = NEEDS % str(build_amount)
	

func rebuild():
	$Bugnest.frame = 1
	$Label.text = TITLE


func _on_Bugnest_body_entered(body):
	if S.is_player(body):
		if $Bugnest.frame == 0:
			emit_signal("visting_nest", self)
		else:
			$Label.text = TITLE
		$Label.show()
			


func _on_Bugnest_body_exited(body):
	if S.is_player(body):
		$Label.hide()
		if $Bugnest.frame == 0:
			emit_signal("left_nest")
		
