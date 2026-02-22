extends Control

@export var deal1: Node3D
@export var deal2: Node3D
@export var deal3: Node3D
@export var deal4: Node3D

func _ready() -> void:
	deal1.set_face(Respondent.random_respondent())
	deal2.set_face(Respondent.random_respondent())
	deal3.set_face(Respondent.random_respondent())
	deal4.set_face(Respondent.random_respondent())
	
	var twn: Tween = create_tween()
	twn.tween_property($Sprite2D, "modulate", Color8(0,0,0,0), 1.0)

func _process(delta: float) -> void:
	deal1.position.z += 0.001
	deal2.position.z += 0.001
	deal3.position.z += 0.001
	deal4.position.z += 0.001
	
	if deal1.position.z > 1:
		deal1.position.z = -1
		deal1.set_face(Respondent.random_respondent())
	if deal2.position.z > 1:
		deal2.position.z = -1
		deal2.set_face(Respondent.random_respondent())
	if deal3.position.z > 1:
		deal3.position.z = -1
		deal3.set_face(Respondent.random_respondent())
	if deal4.position.z > 1:
		deal4.position.z = -1
		deal4.set_face(Respondent.random_respondent())


func _on_exit_pressed() -> void:
	var twn: Tween = create_tween()
	twn.tween_property($Sprite2D, "modulate", Color8(0,0,0,255), 1.0)
	await get_tree().create_timer(1.0).timeout
	get_tree().quit()

func _on_play_pressed() -> void:
	var twn: Tween = create_tween()
	twn.tween_property($Sprite2D, "modulate", Color8(0,0,0,255), 1.0)
	await get_tree().create_timer(1.0).timeout
	Global.balance = 0
	Global.day_count = 1
	Global.money_for_day = 0
	Global.all_accs = []
	get_tree().change_scene_to_file("res://levels/main_level/main_level.tscn")

func _on_tutorial_pressed() -> void:
	var twn: Tween = create_tween()
	twn.tween_property($Sprite2D, "modulate", Color8(0,0,0,255), 1.0)
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://levels/tutorial/tutorial.tscn")
