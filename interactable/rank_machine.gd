extends Interactable

signal choise(loyal, profit)

var is_first: bool = true
var can_be_picked: bool = true

var last_picker

var loyaltyg = 0
var profitg = 0

func _ready() -> void:
	$rank_machine/A/Interactable.connect("button_interacted", press)
	$rank_machine/B/Interactable.connect("button_interacted", press)
	$rank_machine/C/Interactable.connect("button_interacted", press)
	$rank_machine/D/Interactable.connect("button_interacted", press)
	$rank_machine/E/Interactable.connect("button_interacted", press)

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
		can_be_picked = false
		
		var twn: Tween = create_tween()
		twn.set_trans(Tween.TRANS_QUART)
		twn.set_ease(Tween.EASE_IN_OUT)
		var twn2: Tween = create_tween()
		twn2.set_trans(Tween.TRANS_QUART)
		twn2.set_ease(Tween.EASE_IN_OUT)
		twn.tween_property(self, "position", Vector3(0.0,0.0,0.0), 1.0)
		twn2.tween_property(self, "rotation", Vector3(0.0, 0.0, 0.0), 1.0)
		if last_picker:
			last_picker.is_picked = false
		$rank_machine/A/Interactable/CollisionShape3D.disabled = true
		$rank_machine/B/Interactable/CollisionShape3D.disabled = true
		$rank_machine/C/Interactable/CollisionShape3D.disabled = true
		$rank_machine/D/Interactable/CollisionShape3D.disabled = true
		$rank_machine/E/Interactable/CollisionShape3D.disabled = true
		
		choise.emit(loyaltyg, profitg)
		await get_tree().create_timer(0.3).timeout
		$MetalDrop.play()

func reset():
	$rank_machine/Cube_007/MODE.text = "LOYALITY"
	var twn: Tween = create_tween()
	twn.set_trans(Tween.TRANS_QUINT)
	twn.set_ease(Tween.EASE_IN_OUT)
	twn.tween_property($paper, "position", $paper.position - Vector3(0,0,0.1), 1.0)
	is_first = true
	can_be_picked = true

func interact(interactor: Node3D):
	if can_be_picked:
		var twn: Tween = create_tween()
		twn.set_trans(Tween.TRANS_QUART)
		twn.set_ease(Tween.EASE_IN_OUT)
		var twn2: Tween = create_tween()
		twn2.set_trans(Tween.TRANS_QUART)
		twn2.set_ease(Tween.EASE_IN_OUT)
		if !interactor.is_picked:
			$MetalSlide.play()
			last_picker = interactor
			interactor.is_picked = true
			twn.tween_property(self, "global_position", interactor.global_position + -interactor.global_basis.z/1.7, 1.0)
			twn2.tween_property(self, "rotation", Vector3(0.0, interactor.global_rotation.y - deg_to_rad(90), 0.0), 1.0)
			interactor.is_picked = true
			
			$rank_machine/A/Interactable/CollisionShape3D.disabled = false
			$rank_machine/B/Interactable/CollisionShape3D.disabled = false
			$rank_machine/C/Interactable/CollisionShape3D.disabled = false
			$rank_machine/D/Interactable/CollisionShape3D.disabled = false
			$rank_machine/E/Interactable/CollisionShape3D.disabled = false
			return
		$rank_machine/A/Interactable/CollisionShape3D.disabled = true
		$rank_machine/B/Interactable/CollisionShape3D.disabled = true
		$rank_machine/C/Interactable/CollisionShape3D.disabled = true
		$rank_machine/D/Interactable/CollisionShape3D.disabled = true
		$rank_machine/E/Interactable/CollisionShape3D.disabled = true
		twn.tween_property(self, "position", Vector3(0.0,0.0,0.0), 1.0)
		twn2.tween_property(self, "rotation", Vector3(0.0, 0.0, 0.0), 1.0)
		interactor.is_picked = false
		await get_tree().create_timer(0.3).timeout
		$MetalDrop.play()
