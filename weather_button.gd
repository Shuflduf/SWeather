class_name WeatherButton
extends Button

@export var info: Array[String]

func format_data(_i: int) -> String:
	return ""

func format_main() -> String:
	return ""

func _ready() -> void:
	pressed.connect(func():
		if owner.data != {}:
			owner.tab = self
			owner.set_info())
