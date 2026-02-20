extends Node

@export var balance: float = 0.0
@export var day_count: int = 1

var all_accs: Array[int] = []

var player: Camera3D

func get_resp_left() -> int:
	return clamp(day_count * 2 + 1, 1, 10)
