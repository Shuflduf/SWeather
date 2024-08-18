extends Control

@onready var http: HTTPRequest = $HTTPRequest

const url = "https://api.open-meteo.com/v1/forecast"
const tags = ["latitude=40.7143", \
			"longitude=-74.006", \
			"hourly=temperature_2m", \
			"current=temperature_2m", \
			"timezone=Canada%2FMountain"]
# Called when the node enters the scene tree for the first time.

const MONTHS = {
	1: "January",
	2: "Febuary",
	3: "March",
	4: "April",
	5: "May",
	6: "June",
	7: "July",
	8: "August",
	9: "September",
	10: "October",
	11: "November",
	12: "December"
}

func _ready() -> void:
	http.request(make_url())

func make_url():
	var new_url = url
	new_url += "?"
	for tag in tags:
		new_url += tag
		new_url += "&"
	new_url = new_url.rstrip("&")
	return new_url

func _on_http_request_request_completed(_r, _r_code, _h, body: PackedByteArray) -> void:
	FileAccess.open("data.json", FileAccess.WRITE).store_buffer(body)
	var data: Dictionary = JSON.parse_string(body.get_string_from_utf8())
	$MarginContainer/ScrollContainer/Temps/Temp.text = str(data["current"]["temperature_2m"])

	var current_day: int
	var current_hour = Time.get_datetime_dict_from_system()
	for i in data["hourly"]["time"].size():
		var full_time: String = data["hourly"]["time"][i]

		var day = full_time.substr(8, 2)
		if current_day != int(day):
			current_day = int(day)
			%Temps.add_child(HSeparator.new())

		var int_hour = int(full_time.substr(11, 2))
		if int_hour < current_hour["hour"] and int(day) <= current_hour["day"]:
			continue

		var month = MONTHS[int(full_time.substr(5, 2))]
		var str_hour: String
		if int_hour > 11:
			if int_hour - 12 == 0:
				str_hour = str(12) + "PM"
			else:
				str_hour = str(int_hour - 12) + "PM"
		else:
			str_hour = str(int_hour) + "AM"

		var new_label = Label.new()
		new_label.text += month + " "
		new_label.text += day + " "
		new_label.text += str_hour + " "
		new_label.text += str(data["hourly"]["temperature_2m"][i])
		new_label.text += str(data["hourly_units"]["temperature_2m"])

		$MarginContainer/ScrollContainer/Temps.add_child(new_label)
