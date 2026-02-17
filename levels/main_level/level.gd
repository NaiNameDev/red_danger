extends Node3D

var now_resp: Respondent

func _ready() -> void:
	now_resp = Respondent.random_respondent()
	$SubViewportContainer/SubViewport/deal/own_deal.set_face(now_resp)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		_ready()
