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

static
