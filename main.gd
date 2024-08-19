extends Control

@onready var http: HTTPRequest = $HTTPRequest
@onready var tabs: VBoxContainer = $MarginContainer/HBoxContainer/Tabs

@export var tab: WeatherButton

const url = "https://api.open-meteo.com/v1/forecast"

var persistent_tags = [
			"latitude",
			"longitude",
			"timezone" ]

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


enum TemperatureUnits {
	CELSIUS,
	FAHRENHEIT,
}

enum SpeedUnits {
	KMH,
	MS,
	MPH,
	KNOTS,
}

enum PrecipitationUnits {
	MM,
	INCH,
}

var longitude = -113
var latitude = 51
var timezone = ""

var temperature_unit = TemperatureUnits.CELSIUS
var speed_unit = SpeedUnits.KMH
var rain_unit = PrecipitationUnits.MM

var data: Dictionary

func _ready() -> void:
	request.call_deferred()

func request():
	%Main.text = "Loading"
	for i in %Forecast.get_children():
		i.queue_free()
	data = {}
	http.request(make_url())

func make_url():
	var new_url = url
	new_url += "?"

	match temperature_unit:
		TemperatureUnits.FAHRENHEIT:
			new_url += "temperature_unit=fahrenheit&"

	match speed_unit:
		SpeedUnits.MS:
			new_url += "wind_speed_unit=ms&"
		SpeedUnits.MPH:
			new_url += "wind_speed_unit=mph&"
		SpeedUnits.KNOTS:
			new_url += "wind_speed_unit=kn&"

	match rain_unit:
		PrecipitationUnits.INCH:
			new_url += "precipitation_unit=inch&"

	@warning_ignore("shadowed_variable")
	for tab in tabs.get_children():
		for tag in tab.info:
			new_url += tag
			new_url += "&"


	var custom_tag_values = [latitude, longitude, timezone]

	for i in persistent_tags.size():
		var tag = persistent_tags[i]
		var value = custom_tag_values[i]
		new_url += tag + "="
		new_url += str(value)
		new_url += "&"


	new_url = new_url.rstrip("&")
	print(new_url)
	return new_url

func _on_http_request_request_completed(_r, _r_code, _h, body: PackedByteArray) -> void:
	FileAccess.open("data.json", FileAccess.WRITE).store_buffer(body)
	data = JSON.parse_string(body.get_string_from_utf8())
	set_info()

func set_info():
	for i in %Forecast.get_children():
		i.queue_free()
	%Main.text = tab.format_main()

	var current_day: int
	var current_hour = Time.get_datetime_dict_from_system()
	for i in data["hourly"]["time"].size():
		var full_time: String = data["hourly"]["time"][i]

		var day = full_time.substr(8, 2)
		if current_day != int(day):
			current_day = int(day)
			%Forecast.add_child(HSeparator.new())

		var int_hour = int(full_time.substr(11, 2))
		if int_hour < current_hour["hour"] and int(day) <= current_hour["day"]:
			continue

		var str_hour: String
		if int_hour >= 12:
			if int_hour - 12 == 0:
				str_hour = str(12) + "PM"
			else:
				str_hour = str(int_hour - 12) + "PM"
		else:
			str_hour = str(int_hour) + "AM"

		var month = MONTHS[int(full_time.substr(5, 2))]

		var new_label = RichTextLabel.new()
		new_label.bbcode_enabled = true
		new_label.fit_content = true
		new_label.autowrap_mode = TextServer.AUTOWRAP_OFF
		new_label.text += "[font_size=10]"
		new_label.text += month + " "
		new_label.text += day + " "
		new_label.text += str_hour + " "
		new_label.text += "[/font_size]"
		new_label.text += tab.format_data(i)

		%Forecast.add_child(new_label)


func _on_refresh_button_pressed() -> void:
	request()
