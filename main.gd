extends Control

@onready var http: HTTPRequest = $HTTPRequest

const url = "https://api.open-meteo.com/v1/forecast"
const tags = ["latitude=52.52", \
			"longitude=13.41", \
			"hourly=temperature_2m", \
			"timezone=America%2FEdmonton"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	http.request(make_url())

func make_url():
	var new_url = url
	new_url += "?"
	for tag in tags:
		new_url += tag
		new_url += "&"
	new_url = new_url.rstrip("&")
	print(new_url)
	return new_url

func _on_http_request_request_completed(r, r_code, h, body: PackedByteArray) -> void:
	print(body.get_string_from_utf8())
