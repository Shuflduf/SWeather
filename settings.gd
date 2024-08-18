extends Window

@onready var latitude: SpinBox = %Latitude
@onready var longitude: SpinBox = %Longitude
@onready var timezone: LineEdit = %Timezone


func _on_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)


func _on_close_requested() -> void:
	cancel_changes()


func _on_show_button_pressed() -> void:
	show()


func _on_save_pressed() -> void:
	get_parent().latitude = latitude.value
	get_parent().longitude = longitude.value
	get_parent().timezone = timezone.text
	get_parent().request()
	hide()


func _on_cancel_pressed() -> void:
	cancel_changes()

func cancel_changes():
	latitude.value = get_parent().latitude
	longitude.value = get_parent().longitude
	timezone.text = get_parent().timezone
	hide()
