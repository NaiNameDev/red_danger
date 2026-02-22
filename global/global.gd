extends Node

var balance: float = 0
var money_for_day: float = 0
var day_count: int = 1

var all_accs: Array[int] = []

var player: Camera3D

var endless_slave: bool = false

func pay(accurecy: int):
	accurecy += 2
	money_for_day += accurecy * 10 + randi_range(0,10) if accurecy >= 0 else accurecy * 10 - randi_range(0,10)
	print(money_for_day)

func get_resp_left() -> int:
	return clamp(day_count * 2 + 1, 1, 10)

func get_tax():
	return clamp(day_count * 2, 0, 40) + randi_range(10, 20)
