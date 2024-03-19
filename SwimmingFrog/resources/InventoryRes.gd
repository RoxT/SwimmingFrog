class_name Inventory
extends Resource
export(int) var health = 3
export(int) var seaweed = 0 setget set_seaweed
#export(Resource) var sub_resource
#export(Array, String) var strings

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init():
	pass

func set_seaweed(value:int):
	seaweed = value
	emit_changed()
