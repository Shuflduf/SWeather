extends WeatherButton


func format_data(i: int) -> String:
	var new_str = ""
	new_str += str(owner.data["hourly"]["temperature_2m"][i]).pad_decimals(1)
	new_str += str(owner.data["hourly_units"]["temperature_2m"])
	return new_str

func format_main() -> String:

	var new_str = ""
	new_str += str(owner.data["current"]["temperature_2m"]).pad_decimals(1)
	new_str += str(owner.data["hourly_units"]["temperature_2m"])
	return new_str
