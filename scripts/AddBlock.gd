extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var canon := preload("res://prefabs/Canon.tscn").instantiate()
	canon.set_scale(Vector2(2, 2))
	$/root/GameScene.add_child(canon)
	pass # Replace with function body.
