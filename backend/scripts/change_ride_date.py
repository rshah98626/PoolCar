import sys
import requests

# Changes the timestamp of all the rides on a given day to a different day. Allows us to move around data easily while testing.
# Usage: python change_ride_date.py <email> <password> <start_of_day_of_rides_to_change_in_seconds> <day_to_change_to_in_seconds>

login_data = {"email": sys.argv[1], "password": sys.argv[2]}
login_result = requests.post("https://infinite-stream-52265.herokuapp.com/users/verify", data = login_data)
bearer_token = login_result.json()["token"]
headers = {"Authorization": "Bearer " + bearer_token}

offset = 0
rides_query_params = {"destinationLocation": "", "originLocation": "", "startDate": sys.argv[3], "type": "filtered", "offset": str(offset)}
rides_response = requests.get("https://infinite-stream-52265.herokuapp.com/rides/get", headers=headers, params=rides_query_params)
rides = rides_response.json()

rides_changed = 0
time_to_set = int(sys.argv[4])
time_to_set += 36000 # 10 hours, so 10 am of the given input day
while len(rides) > 0:
    for r in rides:
        url = "https://infinite-stream-52265.herokuapp.com/rides/" + r["_id"] + "/update"
        update_payload = {"rideStartTime": time_to_set}
        update_result = requests.put(url, headers=headers, data=update_payload)
        time_to_set += (600)
    rides_changed += len(rides)

    rides_query_params["offset"] = str(offset)
    rides_response = requests.get("https://infinite-stream-52265.herokuapp.com/rides/get", headers=headers, params=rides_query_params)
    rides = rides_response.json()

print("Rides Changed: ", rides_changed)