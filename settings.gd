extends Window



func _on_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)


func _on_close_requested() -> void:
	hide()
