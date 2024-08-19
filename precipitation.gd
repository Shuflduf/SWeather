extends WeatherButton


func format_data(i: int) -> String:
	var new_str = ""
	new_str += str(owner.data["hourly"]["precipitation_probability"][i])
	new_str += str(owner.data["hourly_units"]["precipitation_probability"])
	new_str += " / "
	new_str += str(owner.data["hourly"]["precipitation"][i]) + " "
	new_str += str(owner.data["hourly_units"]["precipitation"])
	return new_str

func format_main() -> String:
	var new_str = ""
	new_str += str(owner.data["current"]["precipitation"]) + " "
	new_str += str(owner.data["hourly_units"]["precipitation"])
	return new_str
