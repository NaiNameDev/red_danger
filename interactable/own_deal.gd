extends Interactable

func set_face(resp: Respondent):
	$info/name.text = resp.name
	$info/scname.text = resp.scname
	$info/age.text = "age: " + str(resp.age)
	$info/bg.text = resp.background
	$info/accusation.text = resp.accusation

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
		twn2.tween_property(self, "rotation", Vector3(interactor.global_rotation.x, 0.0, 0.0), 1.0)
		interactor.is_picked = true
		return
	twn.tween_property(self, "position", Vector3(0.0,0.0,0.0), 1.0)
	twn2.tween_property(self, "rotation", Vector3(0.0, 0.0, 0.0), 1.0)
	interactor.is_picked = false
