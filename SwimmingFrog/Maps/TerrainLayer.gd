extends TileMap

const SEAWEED := preload("res://Seaweed.tscn")
const BOARD := Vector2(1920, 1080)
var food := []

# Called when the node enters the scene tree for the first time.
func _ready():
	food.resize(25)
	
	for f in food:
		f = SEAWEED.instance()
		f.position = Vector2(rand_range(0, BOARD.x), rand_range(0, BOARD.y)).snapped(cell_size)
		
		f.collision_layer = pow(2, get_index())
		f.collision_mask = pow(2, get_index())
		add_child(f)
	var err = connect("visibility_changed", self, "_on_visibility_changed")
	if err != OK: push_warning("Can't connect visibility to self")

func _on_visibility_changed():
	for c in get_children():
		c.visible = visible

func is_rock_at(pos:Vector2)->bool:
	var rock_layer:TileMap = $Rocks
	var tile := rock_layer.get_cellv(rock_layer.world_to_map(pos))
	return tile != INVALID_CELL
