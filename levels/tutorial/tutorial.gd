extends Node3D

@export var player_audio: AudioStreamPlayer3D
@export var resp_audio: AudioStreamPlayer3D

var now_resp: Respondent

func _ready() -> void:
	new_resp()
	var twn: Tween = create_tween()
	twn.tween_property($SubViewportContainer/Sprite2D, "modulate", Color8(0,0,0,0), 1.0)
	
	await get_tree().create_timer(2.0).timeout
	$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.stream = load("res://levels/tutorial/sound/tut1.wav")
	$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.play()
	await $SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.finished
	await get_tree().create_timer(2.0).timeout
	$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.stream = load("res://levels/tutorial/sound/tut2.wav")
	$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.play()
	await $SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.finished
	
	Global.player.can_interact = true

func new_resp():
	now_resp = Respondent.random_respondent()
	$SubViewportContainer/SubViewport/deal/own_deal.set_face(now_resp)
	print(now_resp.loyalty_grade)
	print(now_resp.economy_grade)

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

func _on_rank_machine_choise(loyal: Variant, profit: Variant) -> void:
	Global.player.can_interact = false
	
	if loyal == now_resp.loyalty_grade and profit == now_resp.economy_grade:
		$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.stream = load("res://levels/tutorial/sound/tut_win.wav")
		$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.play()
		await $SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.finished
		var twn: Tween = create_tween()
		twn.tween_property($SubViewportContainer/Sprite2D, "modulate", Color8(0,0,0,255), 1.0)
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://levels/main_level/main_level.tscn")
		return
	elif loyal == now_resp.loyalty_grade or profit == now_resp.economy_grade:
		$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.stream = load("res://levels/tutorial/sound/tut_1_correct.wav")
		$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.play()
		
	elif abs(loyal - now_resp.loyalty_grade) + abs(profit - now_resp.economy_grade) == 2:
		$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.stream = load("res://levels/tutorial/sound/tut_both_little_miss.wav")
		$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.play()
	else:
		$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.stream = load("res://levels/tutorial/sound/tut_bad_shot.wav")
		$SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.play()
	
	await $SubViewportContainer/SubViewport/radio/AudioStreamPlayer3D.finished
	new_resp()
	Global.player.can_interact = true
	$SubViewportContainer/SubViewport/rank/rank_machine.reset()
