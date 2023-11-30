extends Node2D

var canon := preload("res://prefabs/Canon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var canon_inst = canon.instantiate()
	canon_inst.set_scale(Vector2(2, 2))
	canon_inst.can_place = func (this):
		for node in get_tree().get_nodes_in_group("building"):
			if node != this and node.position == this.position:
				return false
		return true
	self.add_child(canon_inst)
