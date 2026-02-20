extends Node3D

var now_resp: Respondent
@export var resp_left: int
@export var resp_counter: Node3D

@export var resp_audio: AudioStreamPlayer3D
@export var player_audio: AudioStreamPlayer3D

@export var player: Node3D

@export var deal: Node3D

func _ready() -> void:
	resp_left = Global.get_resp_left()
	new_resp()
	$SubViewportContainer/SubViewport/rank/rank_machine.connect("choise", fin_choise)

@export var transfer: Node3D
func open_transfer():
	var twn: Tween = create_tween()
	twn.set_trans(Tween.TRANS_BACK)
	twn.set_ease(Tween.EASE_IN_OUT)
	twn.tween_property(transfer, "rotation", Vector3(0,0,-0.8), 1.0)
func close_transfer():
	var twn: Tween = create_tween()
	twn.set_trans(Tween.TRANS_BACK)
	twn.set_ease(Tween.EASE_IN)
	twn.tween_property(transfer, "rotation", Vector3(0,0,0), 1.0)


@export var start_pos: Node3D
@export var second_pos: Node3D
func new_resp():
	Global.player.can_interact = false
	now_resp = Respondent.random_respondent()
	$SubViewportContainer/SubViewport/deal/own_deal.set_face(now_resp)
	resp_counter.set_text("respondents left: " + str(resp_left))
	
	await get_tree().create_timer(1.0).timeout
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
	Global.player.can_interact = true

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
	await get_tree().create_timer(1.0).timeout
	deal.scale = Vector3(0.01,0.01,0.01)
	Global.player.can_interact = true

func fin_choise(loyal, profit):
	var acc: int = -abs(max(loyal, now_resp.loyalty_grade) - min(loyal, now_resp.loyalty_grade)) + -abs(max(profit, now_resp.economy_grade) - min(profit, now_resp.economy_grade))
	Global.all_accs.append(acc)
	
	resp_left -= 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("q1"):
		ask_question(1)
	if event.is_action_pressed("q2"):
		ask_question(2)
	if event.is_action_pressed("q3"):
		ask_question(3)
	if event.is_action_pressed("q4"):
		ask_question(4)
	
	if event.is_action_pressed("debug"):
		new_resp()
	if event.is_action("debug2"):
		lebiral_end()

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
