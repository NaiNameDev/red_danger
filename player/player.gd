extends Camera3D

@export var sens: float = 0.1
@export var interaction_ray: RayCast3D

var is_picked: bool = false
var question_mode: bool = false

@onready var privot = $".."

func _enter_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	if interaction_ray.is_colliding():
		$"../CanvasLayer/TextureRect".visible = !is_picked
	else:
		$"../CanvasLayer/TextureRect".visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("q1") and question_mode:
		question_1()
	if event.is_action_pressed("q2") and question_mode:
		question_2()
	if event.is_action_pressed("q3") and question_mode:
		question_3()
	if event.is_action_pressed("q4") and question_mode:
		question_4()
	if event.is_action_pressed("action"):
		if interaction_ray.is_colliding():
			$"../CanvasLayer/TextureRect".visible = true
			interaction_ray.get_collider().interact(self)
		else:
			$"../CanvasLayer/TextureRect".visible = false
	if event is InputEventMouseMotion:
		rotate_x(deg_to_rad(-event.relative.y * sens))
		privot.rotate_y(deg_to_rad(-event.relative.x * sens))
		
		rotation.x = clampf(rotation.x, deg_to_rad(-60), deg_to_rad(60))
		privot.rotation.y = clampf(privot.rotation.y, deg_to_rad(-89), deg_to_rad(89))

func question_1():
	pass
func question_2():
	pass
func question_3():
	pass
func question_4():
	pass
