extends Interactable

signal button_interacted(grd: Respondent.grades)

var on_entring: bool = false
@export var grade: Respondent.grades

func interact(interactor: Node3D):
	if !on_entring:
		on_entring = true
		var twn: Tween = create_tween()
		twn.set_trans(Tween.TRANS_QUART)
		twn.set_ease(Tween.EASE_IN_OUT)
		twn.tween_property($"..", "position", Vector3($"..".position.x, $"..".position.y - 0.006,$"..".position.z), 0.3)
		$"../../../AudioStreamPlayer3D".play()
		await get_tree().create_timer(0.4).timeout
		var twn2: Tween = create_tween()
		twn2.set_trans(Tween.TRANS_QUART)
		twn2.set_ease(Tween.EASE_IN_OUT)
		twn2.tween_property($"..", "position", Vector3($"..".position.x, $"..".position.y + 0.006,$"..".position.z), 0.3)
		
		await get_tree().create_timer(0.4).timeout
		button_interacted.emit(grade)
		on_entring = false
