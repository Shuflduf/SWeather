extends WeatherButton


func format_data(i: int) -> String:
	return str(owner.data["hourly"]["temperature_2m"][i]).pad_decimals(1)

func format_main() -> String:
	return str(owner.data["current"]["temperature_2m"]).pad_decimals(1)
