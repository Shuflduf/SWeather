extends WeatherButton

func format_data(i: int) -> String:

	var new_string: String = ""

	new_string += str(owner.data["hourly"]["wind_speed_10m"][i])
	new_string += str(owner.data["hourly_units"]["wind_speed_10m"])

	new_string += " at "

	new_string += str(owner.data["hourly"]["wind_direction_10m"][i])
	new_string += str(owner.data["hourly_units"]["wind_direction_10m"])

	return new_string

func format_main() -> String:
	var new_string: String = ""

	new_string += str(owner.data["current"]["wind_speed_10m"])
	new_string += str(owner.data["hourly_units"]["wind_speed_10m"])

	new_string += " at "

	new_string += str(owner.data["current"]["wind_direction_10m"])
	new_string += str(owner.data["hourly_units"]["wind_direction_10m"])

	return new_string
