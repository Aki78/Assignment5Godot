extends Object

var action: String
var payloads: Array
func _init(_action: String, _payloads: Array):
	action = _action
	payloads = _payloads
	
func tostring() -> String:
	var serialize_dict: Dictionary = {"a": action}
	for i in range(len(payloads)):
		serialize_dict["p%d" % i] = payloads[i]
	var data: String = JSON.stringify(serialize_dict)
	return data

func json_to_action_payload(json_str) -> Array:
	var new_json = JSON.new()
	var action: String
	var payload : Array
	var json = new_json.parse(json_str)
	var obj_dict: Dictionary = json.data
	
	
	for key in obj_dict.keys():
		var value = obj_dict[key]
		if key == "a":
			action = value
		elif key[0] == "p":
			var index: int = key.split_floats("p", true)[1]
			payloads.insert(index, value)
	return [action, payloads]
