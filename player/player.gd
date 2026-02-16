extends Camera3D

@export var sens: float = 0.2
@onready var privot = $".."

func _enter_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_x(deg_to_rad(-event.relative.y * sens))
		privot.rotate_y(deg_to_rad(-event.relative.x * sens))
		
		rotation.x = clampf(rotation.x, deg_to_rad(-45), deg_to_rad(45))
		privot.rotation.y = clampf(privot.rotation.y, deg_to_rad(-89), deg_to_rad(89))
