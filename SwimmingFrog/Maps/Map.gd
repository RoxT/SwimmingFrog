extends Node2D


const BOARD := Vector2(1920, 1080)
const TILE_SIZE := 64
const layers := ["Bottom", "Middle", "Top"]
var layer_i := -1
onready var frog = $Frog
onready var hud := $CanvasLayer
onready var inventory := S.inventory
var current_nest

# Called when the node enters the scene tree for the first time.
func _ready():
	for c in $Terrain.get_children():
		c.hide()
	change_layer_to(2)
	hud.refresh_inventory()
	for n in get_tree().get_nodes_in_group("nests"):
		var err = n.connect("visting_nest", self, "_on_nest_visited")
		S.print_err(err, "Error connecting next")
		err = n.connect("left_nest", self, "_on_left_nest")
		S.print_err(err, "Error connecting next")

func change_layer_to(new_layer:int):
	if new_layer != layer_i and !get_layer(new_layer).is_rock_at(frog.position):
		layer_i = new_layer
		change_layer_to(layer_i)
		var layer_maps := $Terrain.get_children()
		for i in range(layer_maps.size()):
			if i <= new_layer:
				layer_maps[i].show()
			else:
				layer_maps[i].hide()
		frog.move_to_layer(layer_i)	
		hud.level(new_layer, layers.size()-1)

func _unhandled_input(event: InputEvent):
	if event is InputEventScreenTouch:
		pass

func get_layer(i:int)->TileMap:
	return $Terrain.get_child(i) as TileMap

func _on_Ascend_pressed():
	change_layer_to(min(layers.size()-1, layer_i+1) as int)

func _on_Descend_pressed():
	change_layer_to(max(0, layer_i-1) as int)

func _on_Direction_button_down(axis:String, strength:int):
	frog[axis] = strength

func _on_Direction_button_up(axis:String):
	frog[axis] = 0

func _on_nest_visited(nest):
	current_nest = nest
	hud.visit_nest(S.inventory.seaweed >= nest.build_amount)
	
func _on_left_nest():
	hud.left_nest()
	current_nest = null
	
func _on_rebuild_pressed():
	S.inventory.seaweed = S.inventory.seaweed - current_nest.build_amount
	current_nest.rebuild()
