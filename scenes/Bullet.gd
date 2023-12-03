class_name Bullet extends RigidBody2D

@export var speed: float
var life: float = 5 # Seconds

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = Vector2(cos(rotation), sin(rotation)) * speed
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	life -= delta
	
	if life < 0:
		self.queue_free()
