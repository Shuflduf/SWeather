extends WeatherButton


func format_data(i: int) -> String:
	return str(owner.data["hourly"]["precipitation_probability"][i]) + "%"

func format_main() -> String:
	return str(owner.data["current"]["precipitation"]).pad_decimals(1)
