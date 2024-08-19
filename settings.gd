extends Window

@onready var latitude: SpinBox = %Latitude
@onready var longitude: SpinBox = %Longitude
@onready var timezone: LineEdit = %Timezone
@onready var temperature: OptionButton = %Temperature
@onready var wind_speed: OptionButton = $VBoxContainer/Speed/WindSpeed
@onready var precipitation: OptionButton = $VBoxContainer/Precipitation/Precipitation


@onready var things = [latitude, longitude, timezone, temperature, wind_speed, precipitation]

func save_dict() -> Dictionary:
	return {
		"latitude" : latitude.value,
		"longitude" : longitude.value,
		"timezone" : timezone.text,
		"temperature" : temperature.selected,
		"wind_speed" : wind_speed.selected,
		"precipitation" : precipitation.selected,
	}

func _on_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)


func _on_close_requested() -> void:
	cancel_changes()


func _on_show_button_pressed() -> void:
	load_data()
	show()


func _on_save_pressed() -> void:
	get_parent().latitude = latitude.value
	get_parent().longitude = longitude.value
	get_parent().timezone = timezone.text

	get_parent().temperature_unit = temperature.selected
	get_parent().speed_unit = wind_speed.selected
	get_parent().rain_unit = precipitation.selected


	get_parent().request()
	hide()

	FileAccess.open("user://settings.txt", FileAccess.WRITE)\
			.store_line(JSON.stringify(save_dict()))


func _on_cancel_pressed() -> void:
	cancel_changes()

func cancel_changes():
	latitude.value = get_parent().latitude
	longitude.value = get_parent().longitude
	timezone.text = get_parent().timezone

	temperature.selected = get_parent().temperature_unit
	wind_speed.selected = get_parent().speed_unit
	precipitation.selected = get_parent().rain_unit

	hide()

func _ready() -> void:
	load_data()

func load_data():
	if !FileAccess.file_exists("user://settings.txt"):
		return
	var data: Dictionary = JSON.parse_string(
		FileAccess.open("user://settings.txt", FileAccess.READ).get_line()
	)

	for i in data.keys().size():

		var prop = ""
		match things[i].get_class():
			"SpinBox":
				prop = "value"
			"LineEdit":
				prop = "text"
			"OptionButton":
				prop = "selected"

		things[i].set(prop, data.values()[i])
