extends Interactable

func interact(interactor: Node3D):
	var twn: Tween = create_tween()
	twn.set_trans(Tween.TRANS_QUART)
	twn.set_ease(Tween.EASE_IN_OUT)
	var twn2: Tween = create_tween()
	twn2.set_trans(Tween.TRANS_QUART)
	twn2.set_ease(Tween.EASE_IN_OUT)
	
	if !interactor.is_picked:
		$pick.play()
		twn.tween_property(self, "global_position", interactor.global_position + -interactor.global_basis.z/2, 1.0)
		twn2.tween_property(self, "rotation", Vector3(interactor.global_rotation.x, -interactor.global_rotation.y/2, 0.0), 1.0)
		interactor.is_picked = true
		interactor.question_mode = true
		return
	$pick.play()
	twn.tween_property(self, "position", Vector3(0.0, 0.0, 0.0), 1.0)
	twn2.tween_property(self, "rotation", Vector3(0.0, 0.0, 0.0), 1.0)
	interactor.is_picked = false
	interactor.question_mode = false
