extends Camera3D

@export var sens: float = 0.1
@export var interaction_ray: RayCast3D

var is_picked: bool = false
var question_mode: bool = false

@onready var privot = $".."

@export var can_interact: bool = false

var menu: bool = false

func _enter_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.player = self

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _process(delta: float) -> void:
	if interaction_ray.is_colliding():
		$"../CanvasLayer/TextureRect".visible = !is_picked
	else:
		$"../CanvasLayer/TextureRect".visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc_menu"):
		menu = !menu
		$"../CanvasLayer/Panel".visible = !$"../CanvasLayer/Panel".visible
		if $"../CanvasLayer/Panel".visible:
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("action") and can_interact:
		if interaction_ray.is_colliding():
			$"../CanvasLayer/TextureRect".visible = true
			interaction_ray.get_collider().interact(self)
		else:
			$"../CanvasLayer/TextureRect".visible = false
	if event is InputEventMouseMotion and !menu:
		rotate_x(deg_to_rad(-event.relative.y * sens))
		privot.rotate_y(deg_to_rad(-event.relative.x * sens))
		
		rotation.x = clampf(rotation.x, deg_to_rad(-60), deg_to_rad(60))
		privot.rotation.y = clampf(privot.rotation.y, deg_to_rad(-89), deg_to_rad(89))


func _on_men_pressed() -> void:
	get_tree().change_scene_to_file("res://global/menu.tscn")

func _on_cnt_pressed() -> void:
	menu = !menu
	$"../CanvasLayer/Panel".visible = !$"../CanvasLayer/Panel".visible
	if $"../CanvasLayer/Panel".visible:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
