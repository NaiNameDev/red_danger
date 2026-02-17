extends Interactable

func set_face(resp: Respondent):
	$info/name.text = resp.name
	$info/scname.text = resp.scname
	$info/age.text = "age: " + str(resp.age)
	$info/bg.text = resp.background

func interact(interactor: Node3D):
	if !interactor.pick:
		interactor.pick = true
		var twn: Tween = create_tween()
		var twn2: Tween = create_tween()
		twn.tween_property(self, "global_position", interactor.global_position + -interactor.global_basis.z/2, 1.0)
		twn2.tween_property(self, "rotation", Vector3(interactor.global_rotation.x, 0.0, 0.0), 1.0)
		interactor.pick = true
		return
	var twn: Tween = create_tween()
	var twn2: Tween = create_tween()
	twn.tween_property(self, "position", Vector3(0.0,0.0,0.0), 1.0)
	twn2.tween_property(self, "rotation", Vector3(0.0, 0.0, 0.0), 1.0)
	interactor.pick = false
