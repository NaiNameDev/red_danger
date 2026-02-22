extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	await get_tree().create_timer(3.0).timeout
	$SubViewportContainer/SubViewport/EndButton.play()
	await get_tree().create_timer(1.7).timeout
	$SubViewportContainer/SubViewport/EndButton.play()
	await get_tree().create_timer(2.0).timeout
	$SubViewportContainer/Sprite2D.visible= true
	$SubViewportContainer/SubViewport/pos1.current = false
	$SubViewportContainer/SubViewport/pos2.current = true
	await get_tree().create_timer(1.7).timeout
	$SubViewportContainer/Sprite2D.visible= false
	await get_tree().create_timer(2.0).timeout
	$SubViewportContainer/Sprite2D.visible= true
	$SubViewportContainer/SubViewport/Shoot2.play()
	await get_tree().create_timer(10.0).timeout
	get_tree().change_scene_to_file("res://global/menu.tscn")
