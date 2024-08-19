extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	meta_clicked.connect(func(meta):
		OS.shell_open(meta))
