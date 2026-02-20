extends Area3D
class_name Interactable

signal interacted

func interact(interactor: Node3D):
	print(interactor.name)
	interacted.emit()
