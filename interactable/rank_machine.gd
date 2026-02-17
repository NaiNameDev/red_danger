extends Interactable

var is_first: bool = true

var loyaltyg = 0
var profitg = 0

func press(grade: Respondent.grades):
	if is_first:
		loyaltyg = grade
		$rank_machine/Cube_007/MODE.text = "PROFITABILITY"
		var twn: Tween = create_tween()
		twn.set_trans(Tween.TRANS_QUINT)
		twn.set_ease(Tween.EASE_IN_OUT)
		twn.tween_property($paper, "position", $paper.position + Vector3(0,0,0.1), 1.0)
		is_first = false
	else:
		profitg = grade

func interact(interactor: Node3D):
	var twn: Tween = create_tween()
	twn.set_trans(Tween.TRANS_QUART)
	twn.set_ease(Tween.EASE_IN_OUT)
	var twn2: Tween = create_tween()
	twn2.set_trans(Tween.TRANS_QUART)
	twn2.set_ease(Tween.EASE_IN_OUT)
	if !interactor.is_picked:
		interactor.is_picked = true
		twn.tween_property(self, "global_position", interactor.global_position + -interactor.global_basis.z/2, 1.0)
		twn2.tween_property(self, "rotation", Vector3(0.0, interactor.global_rotation.y - deg_to_rad(90), 0.0), 1.0)
		interactor.is_picked = true
		
		return
	press(1)
	
	twn.tween_property(self, "position", Vector3(0.0,0.0,0.0), 1.0)
	twn2.tween_property(self, "rotation", Vector3(0.0, 0.0, 0.0), 1.0)
	interactor.is_picked = false
