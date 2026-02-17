extends Camera3D

@export var sens: float = 0.1
@export var interaction_ray: RayCast3D

var pick = false

@onready var privot = $".."

func _enter_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action"):
		if interaction_ray.is_colliding():
			interaction_ray.get_collider().interact(self)
	if event is InputEventMouseMotion:
		rotate_x(deg_to_rad(-event.relative.y * sens))
		privot.rotate_y(deg_to_rad(-event.relative.x * sens))
		
		rotation.x = clampf(rotation.x, deg_to_rad(-60), deg_to_rad(60))
		privot.rotation.y = clampf(privot.rotation.y, deg_to_rad(-89), deg_to_rad(89))
