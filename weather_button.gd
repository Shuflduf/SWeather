class_name WeatherButton
extends Button

@export var info: Array[String]

func format_data(i: int) -> String:
	return ""

func format_main() -> String:
	return ""

func _ready() -> void:
	pressed.connect(func():
		owner.tab = self
		owner.set_info())
