extends WeatherButton


func format_data(i: int) -> String:
	var new_str = ""
	new_str += str(owner.data["hourly"]["cloud_cover"][i])
	new_str += str(owner.data["hourly_units"]["cloud_cover"])
	return new_str

func format_main() -> String:
	var new_str = ""
	new_str += str(owner.data["current"]["cloud_cover"])
	new_str += str(owner.data["hourly_units"]["cloud_cover"])
	return new_str
