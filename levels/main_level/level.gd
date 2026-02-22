extends Node3D

var now_resp: Respondent
@export var resp_left: int
@export var resp_counter: Node3D

@export var resp_audio: AudioStreamPlayer3D
@export var player_audio: AudioStreamPlayer3D
@export var day_end_sound: AudioStreamPlayer3D

@export var player: Node3D

@export var deal: Node3D

@export_group("corpse")
@export var corpse_soldier: Node3D
@export var corpse_soldier_start: Node3D
@export var corpse_soldier_end: Node3D
@export var corpse_soldier_anim: AnimationPlayer

@export_group("cityzen")
@export var cityzen: Node3D
@export var cityzen_start: Node3D
@export var cityzen_end: Node3D
@export var cityzen_end2: Node3D

@export_group("locales")
func _ready() -> void:
	resp_left = Global.get_resp_left()
	new_resp()
	$SubViewportContainer/SubViewport/rank/rank_machine.connect("choise", fin_choise)
	var twn: Tween = create_tween()
	twn.tween_property($SubViewportContainer/Sprite2D, "modulate", Color8(0,0,0,0), 1.0)

func go_corpse():
	corpse_soldier.global_position = corpse_soldier_start.global_position
	corpse_soldier_anim.play("walk")
	var twn: Tween = create_tween()
	twn.tween_property(corpse_soldier, "position", corpse_soldier_end.global_position, 8.0)

func go_in_cityzen():
	cityzen.global_position = cityzen_start.global_position
	cityzen.rotation = Vector3(0,deg_to_rad(180),0)
	var twn: Tween = create_tween()
	twn.tween_property(cityzen, "global_position", cityzen_end.global_position, 4.0)
	twn.tween_property(cityzen, "rotation", Vector3(0,deg_to_rad(-90),0), 1.0)

func go_out_citizen():
	var twn: Tween = create_tween()
	twn.tween_property(cityzen, "rotation", Vector3(0,deg_to_rad(-180),0), 1.0)
	twn.tween_property(cityzen, "global_position", cityzen_end2.global_position, 4.0)

@export var transfer: Node3D
func open_transfer():
	var twn: Tween = create_tween()
	$SubViewportContainer/SubViewport/Metalopen.play()
	twn.set_trans(Tween.TRANS_BACK)
	twn.set_ease(Tween.EASE_IN_OUT)
	twn.tween_property(transfer, "rotation", Vector3(0,0,-0.8), 1.0)
func close_transfer():
	var twn: Tween = create_tween()
	twn.set_trans(Tween.TRANS_BACK)
	twn.set_ease(Tween.EASE_IN)
	twn.tween_property(transfer, "rotation", Vector3(0,0,0), 1.0)
	await get_tree().create_timer(0.2).timeout
	$SubViewportContainer/SubViewport/Metalclose.play()


func end_dey():
	resp_counter.set_text("your work is finished!")
	day_end_sound.play()
	await get_tree().create_timer(3.0).timeout
	var twnn: Tween = create_tween()
	await twnn.tween_property($SubViewportContainer/Sprite2D, "modulate", Color8(0,0,0,255), 1.0).finished
	Global.day_count += 1
	get_tree().change_scene_to_file("res://levels/selery/show_selery.tscn")

@export var start_pos: Node3D
@export var second_pos: Node3D
func new_resp():
	Global.player.can_interact = false
	if resp_left == -1:
		end_dey()
		return
	
	$SubViewportContainer/SubViewport/Door.play()
	go_in_cityzen()
	now_resp = Respondent.random_respondent()
	$SubViewportContainer/SubViewport/deal/own_deal.set_face(now_resp)
	resp_counter.set_text("respondents left: " + str(resp_left))
	
	await get_tree().create_timer(5.0).timeout
	open_transfer()
	await get_tree().create_timer(0.4).timeout
	deal.global_position = start_pos.global_position
	deal.scale = Vector3(1,1,1)
	deal.rotation.x = 0.7
	
	var twn: Tween = create_tween()
	twn.set_trans(Tween.TRANS_QUART)
	twn.set_ease(Tween.EASE_IN_OUT)
	var twn2: Tween = create_tween()
	twn.set_trans(Tween.TRANS_QUART)
	twn.set_ease(Tween.EASE_IN_OUT)
	
	twn.tween_property(deal, "global_position", second_pos.global_position, 1.0)
	twn.tween_property(deal, "position", Vector3(0,0,0), 1.0)
	await twn2.tween_property(deal, "rotation", Vector3(0,0,0), 1.0).finished
	close_transfer()
	Global.player.can_interact = true
	

@export var drop_pos: Node3D
@export var drop_pos_two: Node3D
func death_end():
	Global.player.can_interact = false
	var twn: Tween = create_tween()
	twn.set_trans(Tween.TRANS_QUART)
	twn.set_ease(Tween.EASE_IN_OUT)
	
	twn.tween_property(deal, "global_position", drop_pos.global_position, 1.0)
	twn.tween_property(deal, "global_position", drop_pos_two.global_position, 1.0)
	await twn.tween_property(deal, "scale", Vector3(0,0,0), 1.0).finished
	#Global.player.can_interact = true
	await get_tree().create_timer(3.0).timeout
	$SubViewportContainer/SubViewport/Shoot.play()
	await get_tree().create_timer(2.0).timeout
	go_corpse()

func lebiral_end():
	var twn: Tween = create_tween()
	twn.set_trans(Tween.TRANS_QUART)
	twn.set_ease(Tween.EASE_IN_OUT)
	var twn2: Tween = create_tween()
	twn.set_trans(Tween.TRANS_QUART)
	twn.set_ease(Tween.EASE_IN_OUT)
	
	open_transfer()
	twn.tween_property(deal, "global_position", second_pos.global_position, 1.0)
	twn.tween_property(deal, "global_position", start_pos.global_position, 1.0)
	await twn2.tween_property(deal, "rotation", Vector3(0.7,0,0), 1.0).finished
	close_transfer()
	await get_tree().create_timer(0.8).timeout
	deal.scale = Vector3(0.01,0.01,0.01)
	#Global.player.can_interact = true

func fin_choise(loyal, profit):
	var acc: int = -abs(max(loyal, now_resp.loyalty_grade) - min(loyal, now_resp.loyalty_grade)) + -abs(max(profit, now_resp.economy_grade) - min(profit, now_resp.economy_grade))
	Global.all_accs.append(acc)
	Global.pay(acc)
	go_out_citizen()
	Global.player.can_interact = false
	
	resp_left -= 1
	if loyal == 4 or profit == 4:
		death_end()
	else:
		lebiral_end()
	await get_tree().create_timer(5.0).timeout
	
	$SubViewportContainer/SubViewport/rank/rank_machine.reset()
	await get_tree().create_timer(4.0).timeout
	new_resp()

func _input(event: InputEvent) -> void:
	if Global.player.can_interact:
		if event.is_action_pressed("q1") and !player_audio.playing and !resp_audio.playing:
			ask_question(1)
		if event.is_action_pressed("q2") and !player_audio.playing and !resp_audio.playing:
			ask_question(2)
		if event.is_action_pressed("q3") and !player_audio.playing and !resp_audio.playing:
			ask_question(3)
		if event.is_action_pressed("q4") and !player_audio.playing and !resp_audio.playing:
			ask_question(4)

func ask_question(qnumber: int):
	match qnumber:
		1:
			player_audio.stream = load("res://player/voise_lines/q1.wav")
			player_audio.play()
			await player_audio.finished
			await get_tree().create_timer(randf_range(0.5, 1.5)).timeout
			resp_audio.stream = now_resp.q1_answear
			resp_audio.play()
		2:
			player_audio.stream = load("res://player/voise_lines/q2.wav")
			player_audio.play()
			await player_audio.finished
			await get_tree().create_timer(randf_range(0.5, 1.5)).timeout
			resp_audio.stream = now_resp.q2_answear
			resp_audio.play()
		3:
			player_audio.stream = load("res://player/voise_lines/q3.wav")
			player_audio.play()
			await player_audio.finished
			await get_tree().create_timer(randf_range(0.5, 1.5)).timeout
			resp_audio.stream = now_resp.q3_answear
			resp_audio.play()
		4:
			player_audio.stream = load("res://player/voise_lines/q4.wav")
			player_audio.play()
			await player_audio.finished
			await get_tree().create_timer(randf_range(0.5, 1.5)).timeout
			resp_audio.stream = now_resp.q4_answear
			resp_audio.play()
