extends Node3D

var now_resp: Respondent

@onready var resp_audio: AudioStreamPlayer3D = $SubViewportContainer/SubViewport/AudioStreamPlayer3D
@onready var player_audio: AudioStreamPlayer3D = $SubViewportContainer/SubViewport/AudioStreamPlayer3D2

func _ready() -> void:
	now_resp = Respondent.random_respondent()
	$SubViewportContainer/SubViewport/deal/own_deal.set_face(now_resp)
	$SubViewportContainer/SubViewport/rank/rank_machine.connect("choise", fin_choise)

func fin_choise(loyal, profit):
	print(loyal)
	print(profit)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		_ready()
		ask_question(1)

func ask_question(qnumber: int):
	match qnumber:
		1:
			player_audio.stream = load("res://player/voise_lines/q1.wav")
			player_audio.play()
			await player_audio.finished
			resp_audio.stream = now_resp.q1_answear
			resp_audio.play()
		2:
			player_audio.stream = load("res://player/voise_lines/q2.wav")
			player_audio.play()
			await player_audio.finished
			resp_audio.stream = now_resp.q2_answear
			resp_audio.play()
		3:
			player_audio.stream = load("res://player/voise_lines/q3.wav")
			player_audio.play()
			await player_audio.finished
			resp_audio.stream = now_resp.q3_answear
			resp_audio.play()
		4:
			player_audio.stream = load("res://player/voise_lines/q4.wav")
			player_audio.play()
			await player_audio.finished
			resp_audio.stream = now_resp.q4_answear
			resp_audio.play()
