extends Node


var inventory := Inventory.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func my_collisions(node:CollisionObject2D):
	var parent := node.get_parent()
	while not parent is TileMap:
		parent = parent.get_parent()
	node.collision_layer = parent.collision_layer
	node.collision_mask = parent.collision_mask

func print_errs(errs:Array, msg:String):
	for e in errs:
		print_err(e, msg)

func print_err(e:int, msg:String):
		if e != OK: 
			push_warning(msg + str(e))
	
