extends WeatherButton


func format_data(i: int) -> String:
	var new_str = ""
	new_str += str(owner.data["hourly"]["surface_pressure"][i]).pad_decimals(0)
	new_str += str(owner.data["hourly_units"]["surface_pressure"])
	return new_str

func format_main() -> String:
	var new_str = ""
	new_str += str(owner.data["current"]["surface_pressure"]).pad_decimals(0)
	new_str += str(owner.data["hourly_units"]["surface_pressure"])
	return new_str
