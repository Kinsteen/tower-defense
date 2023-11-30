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
	self.add_child(canon_inst)
