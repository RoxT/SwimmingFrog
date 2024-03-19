extends CanvasLayer

const thing_label = "%s: %s"

signal direction_button_down(axis, strength)
signal direction_button_up(axis)
signal ascend_pressed
signal descend_pressed
signal rebuild_pressed
const X := "x"
const Y := "y"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_buttons(get_parent())

func refresh_inventory():
	for c in $Properties.get_children():
		c.queue_free()
	var inv := S.inventory
	var things:Array = inv.get_property_list()
	for thing in things:
		thing = thing as Dictionary
		if thing.get("usage", 0) == 8199:
			var label := Label.new()
			label.text = thing_label % [thing.name, inv.get(thing.name)]
			$Properties.add_child(label)

func level(new_l:int, top:int):
	$Level.text = "Level: " + str(new_l)
	$Level/Floor.visible = new_l == 0
	$Level/Top.visible = new_l == top
	

func connect_buttons(node:Node):
	var errs := []
	errs.append( connect("ascend_pressed", node, "_on_Ascend_pressed") )
	errs.append( connect("descend_pressed", node, "_on_Descend_pressed") )
	errs.append( connect("direction_button_down", node, "_on_Direction_button_down") )
	errs.append( connect("direction_button_up", node, "_on_Direction_button_up") )
	errs.append( S.inventory.connect("changed", self, "refresh_inventory") )
	errs.append( connect("rebuild_pressed", node, "_on_rebuild_pressed") )
	for e in errs:
		if e != OK: push_warning("Err connecting HUD: " + str(e))
		

func visit_nest(can_build:bool):
	$RebuildNest.visible = can_build
	
func left_nest():
	$RebuildNest.hide()

func _on_RebuildNest_pressed():
	emit_signal("rebuild_pressed")
	$RebuildNest.hide()

func _on_Ascend_pressed():
	emit_signal("ascend_pressed")

func _on_Descend_pressed():
	emit_signal("descend_pressed")

func _on_Up_button_down():
	emit_signal("direction_button_down", Y, -1)

func _on_Up_button_up():
	emit_signal("direction_button_up", Y)

func _on_Down_button_down():
	emit_signal("direction_button_down", Y, 1)

func _on_Down_button_up():
	emit_signal("direction_button_up", Y)

func _on_Right_button_down():
	emit_signal("direction_button_down", X, 1)

func _on_Right_button_up():
	emit_signal("direction_button_up", X)

func _on_Left_button_down():
	emit_signal("direction_button_down", X, -1)

func _on_Left_button_up():
	emit_signal("direction_button_up", X)
	
func _diagonal_up():
	emit_signal("direction_button_up", Y)
	emit_signal("direction_button_up", X)

func _on_DL_button_down():
	emit_signal("direction_button_down", Y, 1)
	emit_signal("direction_button_down", X, -1)

func _on_DL_button_up():
	_diagonal_up()

func _on_DR_button_down():
	emit_signal("direction_button_down", Y, 1)
	emit_signal("direction_button_down", X, 1)

func _on_DR_button_up():
	_diagonal_up()

func _on_UR_button_down():
	emit_signal("direction_button_down", Y, -1)
	emit_signal("direction_button_down", X, 1)

func _on_UR_button_up():
	_diagonal_up()

func _on_UL_button_down():
	emit_signal("direction_button_down", Y, -1)
	emit_signal("direction_button_down", X, 1)

func _on_UL_button_up():
	_diagonal_up()

