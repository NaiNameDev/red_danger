extends Node3D

@export var can_exit: bool = false
var game_over: bool = false
var GOOD_ENDING: bool = false

func _ready() -> void:
	var tax = Global.get_tax()
	
	var open_twn: Tween = create_tween()
	open_twn.tween_property($Sprite2D, "modulate", Color8(0,0,0,0), 1.0)
	
	await get_tree().create_timer(1.0).timeout
	$convert/PismoOpen.play()
	$convert/MeshInstance3D/Label3D2.text = str(snappedf(Global.balance + Global.money_for_day - tax, 0.01)) + "$"
	var twn: Tween = create_tween()
	twn.set_trans(Tween.TRANS_QUINT)
	twn.set_ease(Tween.EASE_IN_OUT)
	twn.tween_property($convert/roll_point, "rotation", Vector3(0, 0, -2), 1.0)
	
	if Global.money_for_day >= 0:
		$convert/roll_point/MeshInstance3D2/Label3D.text = "your seley is: " + str(Global.money_for_day)
	else:
		$convert/roll_point/MeshInstance3D2/Label3D.text = "you worked very poorly, you were fined in the amount of " + str(Global.money_for_day)
	
	$convert/roll_point/MeshInstance3D2/Label3D.text += '\n'
	$convert/roll_point/MeshInstance3D2/Label3D.text += "And you will also be charged a life tax of " + str(tax) + "$"
	
	twn.tween_property($convert, "global_position", $convert.global_position + ($convert/roll_point.global_position - $SubViewportContainer/SubViewport/Camera3D.global_position).normalized() * -0.5, 1.0)
	
	Global.balance -= tax
	Global.balance += Global.money_for_day
	Global.money_for_day = 0
	
	if Global.balance >= 1000.0 and !Global.endless_slave:
		$timer_for_stupid_players.stop()
		$convert/MeshInstance3D/Label3D2.visible = false
		$convert/MeshInstance3D/Label3D.text = "You have worked hard enough and now you have enough money to buy yourself out of slavery! left mouse button to finish the game OR right mouse button to remain in slavery"
		$convert/MeshInstance3D/Label3D.scale.y += 0.3
		GOOD_ENDING = true
	
	if Global.balance <= -100.0:
		$convert/MeshInstance3D/Label3D2.visible = false
		$convert/MeshInstance3D/Label3D.text = "Your debt has exceeded all permissible limits. You are required to appear for the procedure at the nearest distribution point on 05/07/98 at 12:15."
		$convert/MeshInstance3D/Label3D.scale.y += 0.2
		game_over = true
	
	await get_tree().create_timer(3.0).timeout
	can_exit = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and can_exit:
		var open_twn: Tween = create_tween()
		open_twn.tween_property($Sprite2D, "modulate", Color8(0,0,0,255), 1.0)
		can_exit = false
		await get_tree().create_timer(1.0).timeout
		if game_over:
			get_tree().change_scene_to_file("res://levels/game_over/game_over.tscn")
			return
		if GOOD_ENDING:
			get_tree().change_scene_to_file("res://global/menu.tscn")
			return
		
		get_tree().change_scene_to_file("res://levels/main_level/main_level.tscn")
	if event.is_action_pressed("stay_slave"):
		if GOOD_ENDING:
			Global.endless_slave = true
			var open_twn: Tween = create_tween()
			open_twn.tween_property($Sprite2D, "modulate", Color8(0,0,0,255), 1.0)
			can_exit = false
			await get_tree().create_timer(1.0).timeout
			get_tree().change_scene_to_file("res://levels/main_level/main_level.tscn")

func _on_timer_for_stupid_players_timeout() -> void:
	$Label.visible = true
