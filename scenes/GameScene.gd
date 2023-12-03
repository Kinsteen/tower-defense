extends Node2D

var canon := preload("res://prefabs/Canon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	GuiEvents.create_canon.connect(_create_canon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _create_canon():
	var canon_inst = canon.instantiate()
	canon_inst.can_place = func (this):
		for node in get_tree().get_nodes_in_group("building"):
			if node != this and node.position == this.position:
				return false
		return true
	self.add_child(canon_inst)
